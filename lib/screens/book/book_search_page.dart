import 'package:bookmarkfront/api/book_api.dart';
import 'package:bookmarkfront/models/book.dart';
import 'package:bookmarkfront/screens/book/book_detail_page.dart';
import 'package:bookmarkfront/utils/global_util.dart';
import 'package:bookmarkfront/widgets/app_bars.dart';
import 'package:bookmarkfront/widgets/bottom_navigation_bar.dart';
import 'package:bookmarkfront/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class BookSearchPage extends StatefulWidget {
  const BookSearchPage({super.key});

  @override
  State<BookSearchPage> createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage> {
  
  final queryController = TextEditingController();
  
  List<Book> searchedBooks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "도서 검색"
      ),
      body: SafeArea(
        child: Padding(
          padding: getMainPadding(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: "책 검색", 
                        obscureText: false, 
                        controller: queryController, 
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () async{
                        FocusScope.of(context).unfocus();
                        final response = await getBooksByQuery(context, queryController.text);
                        setState(() {
                          searchedBooks = response; 
                        });
                      },
                      child: Icon(
                        Icons.search,
                        size: 35,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: searchedBooks.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: index == searchedBooks.length - 1 ? 0 : 25),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: _bookLayout(searchedBooks[index],index),
                        ),
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: getBottomBar(
        context, 1
      ),
    );
  }

  InkWell _bookLayout(Book book,int index) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailPage(book : book),
          )
        );
      },
      child : Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              book.imageUrl,
              width: 103,
              height: 152,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 15),
          Expanded(  
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${index+1}",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  book.title,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Text(
                  book.author,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color.fromRGBO(23, 20, 46, 0.62),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Text(
                  book.contents,
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Color.fromRGBO(23, 20, 46, 0.62),
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
