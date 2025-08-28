import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrivacyTermsPage extends StatelessWidget {
  
  const PrivacyTermsPage({super.key});

  final String companyName = "책갈피";
  final String contactEmail = "bookmarkapp2025@gmail.com";
  final String lastUpdated = "2025-08-28";
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('정책 및 약관'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '개인정보처리방침'),
              Tab(text: '이용약관'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _PolicyView(
              title: '개인정보처리방침',
              companyName: companyName,
              contactEmail: contactEmail,
              lastUpdated: lastUpdated,
              policyText: _defaultPrivacyPolicy,
            ),
            _PolicyView(
              title: '이용약관',
              companyName: companyName,
              contactEmail: contactEmail,
              lastUpdated: lastUpdated,
              policyText: _defaultTermsOfService,
            ),
          ],
        ),
      ),
    );
  }
}

class _PolicyView extends StatelessWidget {
  final String title;
  final String companyName;
  final String contactEmail;
  final String lastUpdated;
  final String policyText;

  const _PolicyView({
    super.key,
    required this.title,
    required this.companyName,
    required this.contactEmail,
    required this.lastUpdated,
    required this.policyText,
  });

  @override
  Widget build(BuildContext context) {
    final updated = lastUpdated;

    return SafeArea(
      child: Column(
        children: [
          _Header(companyName: companyName, contactEmail: contactEmail, updated: updated),
          const Divider(height: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: SelectableText(
                    policyText,
                    style: const TextStyle(fontSize: 14.0, height: 1.6),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String companyName;
  final String contactEmail;
  final String updated;

  const _Header({
    super.key,
    required this.companyName,
    required this.contactEmail,
    required this.updated,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(companyName, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('문의: $contactEmail', style: TextStyle(color: Colors.grey[700], fontSize: 12)),
              ],
            ),
          ),
          Text('최종 수정: $updated', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }
}

// 기본 개인정보처리방침 (Member 엔티티 기준)
const String _defaultPrivacyPolicy = '''
1. 수집하는 개인정보의 항목
- 필수항목: 이메일, 비밀번호, 이름, 닉네임, 성별, 전화번호, 생년월일
- 선택항목: 프로필 이미지
- 자동수집: 마지막 로그인 시간(시스템 기록), 계정 생성일(시스템 기록) ,디바이스 정보, IP 주소

2. 개인정보 수집 및 이용 목적
- 회원 가입 및 본인 확인
- 서비스 이용 기록 관리 및 보안
- 고객 문의 대응

3. 보관 및 이용 기간
- 회원 탈퇴 시 즉시 파기(단, 관련 법령에 따른 보존 의무가 있는 경우 예외)

4. 개인정보 제3자 제공
- 원칙적으로 제공하지 않음

5. 파기절차 및 방법
- 전자적 파일: 복구 불가능한 방법으로 영구 삭제

6. 자동수집 정보의 이용
- 앱은 디바이스 정보, IP 주소 등을 자동으로 수집할 수 있으며, 이 정보는 보안 강화 및 서비스 품질 개선에만 사용됩니다.

7. 이용자의 권리
- 이용자는 언제든지 자신의 개인정보에 대해 열람, 수정, 삭제를 요청할 수 있습니다. 요청은 앱 내 설정 또는 이메일을 통해 가능합니다.

8. 안전성 확보 조치
- 비밀번호 암호화 (bcrypt 암호화 방식)
- 서버 접근 권한 제한 (토큰 관리)
- 통신 구간 암호화 (HTTPS/SSL)

※ 본 정책은 앱 기능 또는 법령에 따라 변경될 수 있으며, 변경 시 앱 내 공지 또는 이메일로 안내합니다.
''';

const String _defaultTermsOfService = '''
1. 서비스 내용
- 본 앱은 사용자에게 책 검색 및 독서 기록 서비스 등을 제공합니다.
- 앱에서 표시되는 책 정보는 외부 OpenAPI(예: 알라딘 OpenAPI)를 통해 제공될 수 있습니다.

2. 외부 API 사용 안내
- 책 정보 및 메타데이터는 알라딘 OpenAPI에서 가져오며, 해당 데이터의 저작권은 제공사에 있습니다.
- 외부 API의 정책 변경, 서비스 중단 등에 따라 일부 기능이 제한될 수 있습니다.

3. 계정 및 이용제한
- 이용자는 이메일/비밀번호를 통해 계정을 만들고 관리할 책임이 있습니다.
- 부정한 이용이 확인될 경우 서비스 이용 제한 또는 계정 삭제가 이루어질 수 있습니다.

4. 저작권 및 책임
- 앱에 표시된 콘텐츠(텍스트, 이미지 등)의 저작권은 각 제공자에게 있으며, 무단 복제 및 배포를 금합니다.
- 앱 운영자는 고의 또는 중대한 과실이 없는 한 서비스 내용에 대해 책임을 지지 않습니다.

5. 약관 변경
- 약관은 사전 공지 후 변경될 수 있습니다. 중요한 변경 시 개별 공지 또는 이메일로 안내합니다.

6. 문의
- 서비스 관련 문의: bookmarkapp2025@gmail.com
''';
