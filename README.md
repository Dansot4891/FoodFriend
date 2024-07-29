#### FoodFriend
![image](https://github.com/user-attachments/assets/332bc7ff-f8d6-491b-88b9-c0d7280cbeb4)
------------------------------------------------------------
처음 시작해보는 Flutter를 이용한 개인 프로젝트
가천대학교 학교내에서 같이 밥 먹을 사람을 구하는 앱

피그마 : https://www.figma.com/design/BnN9LHItd5SCAXGvRzPSzV/Food-Friends?t=UIef7yGQMMzmNt6C-0

기능
1. 로그인/회원가입/정보 수정
2. 팀 생성/참가/수정/삭제
3. 음식 랜덤 추천 -> 이미지까지 출력 후 해당 카테고리에 대한 팀 생성/이동 가능
4. 노쇼 유저 신고

특징
1. FireBase 연동하여 서버 대체
2. FireBase 연동 코드 mixin 활용하여 일반화
3. 모든 데이터는 riverpod을 이용하여 저장/정제/생성 이용
4. 여러 디벨롭/패키지 이용
(기존엔 데이터를 받아와서 바로 이용하고 FutureBuilder 이용 등 다른 방법이었으나 새로운 패키지/방법 꾸준히 도입)
5. 이미지 캐싱(이미지 크기로 인하여 바로 출력이 안되면 로딩 화면 구성 - 패키지 이용)

꾸준히 develop 중!
