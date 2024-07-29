## FoodFriend
![image](https://github.com/user-attachments/assets/332bc7ff-f8d6-491b-88b9-c0d7280cbeb4)
------------------------------------------------------------
## 개발 환경

Flutter / FireBase
------------------------------------------------------------
## 팀원 소개

가천대학교 금융수학과 임명우
------------------------------------------------------------
## 개발 기간

2023-09-02 ~ 2024-07-01
※ 일부 구현이 완료된 상태에서 깃과 연결하여 개발 기간은 실제 기간과 차이가 발생할 수 있습니다.
------------------------------------------------------------
## 프로젝트 소개
+ Food Friend는 가천대학교 학생들이 자유롭게 밥 친구를 구할 수 있는 앱입니다.
+ 사용자는 원하는 정보를 입력하여 파티를 만들거나 다른 사용자가 만든 파티에 자유롭게 참가할 수 있습니다.
+ 파티에 대한 생성/삭제/수정이 모두 가능합니다.
+ 사용자 노쇼를 위한 신고 기능 및 음식 추천 기능을 구현하였습니다.
------------------------------------------------------------
## 화면 구성
<p align="center">
   <img src="https://github.com/user-attachments/assets/5c537314-b864-4879-b966-eb55c6b1871c" align="center" width="32%">
   <img src="https://github.com/user-attachments/assets/4346a817-1fbf-4f66-b104-fbc1664d5626" align="center" width="32%">
   <img src="https://github.com/user-attachments/assets/69c4a85e-1a62-41bf-93ca-582a2db331b4" align="center" width="32%">
</p>
<p align="center">
   <img src="https://github.com/user-attachments/assets/5c537314-b864-4879-b966-eb55c6b1871c" align="center" width="32%">
   <img src="https://github.com/user-attachments/assets/1fc6cbe7-ad5c-41e5-b6e2-34e68077b9d8" align="center" width="32%">
   <img src="https://github.com/user-attachments/assets/839b9e4a-de80-4504-a8f9-1ce626caebcb" align="center" width="32%">
</p>
<p align="center">
   <img src="https://github.com/user-attachments/assets/bb32aa6d-e099-4a1f-a321-4570ac204460" align="center" width="32%">
   <img src="https://github.com/user-attachments/assets/692ea3bf-c2f3-4d53-96e9-74b9d1fea106" align="center" width="32%">
   <img src="https://github.com/user-attachments/assets/837132e8-4fc6-4ca8-ae28-036837c506ff" align="center" width="32%">
</p>
<p align="center">
   <img src="https://github.com/user-attachments/assets/1fcc5638-108c-4392-b72c-f814b5440cb9" align="center" width="32%">
   <img src="https://github.com/user-attachments/assets/a7104339-f7e6-4d99-99cf-7b491435b746" align="center" width="32%">
</p>

------------------------------------------------------------
## 기능
1. 로그인/회원가입/정보 수정
   + TextField 유효성 검사가 구현돼있습니다.
   + 사용자가 자유롭게 정보를 기입하고 로그인하고, 정보 수정이 가능합니다.
2. 팀 생성/참가/수정/삭제
   + 팀 생성자는 팀에 대한 정보 기입이 가능하며 생성/수정/삭제가 모두 가능합니다.
3. 음식 랜덤 추천 -> 이미지까지 출력 후 해당 카테고리에 대한 팀 생성/이동 가능
   + 각 카테고리 별로 저장된 데이터안에서 사용자에게 이미지와 함께 음식 추천이 가능합니다.
4. 노쇼 유저 신고
   + 팀 생성 후 참가하였으나 노쇼하는 인원에 대해서 신고 기능이 구현돼있습니다.

## 특징
1. FireBase를 연동하여 데이터를 관리합니다.
2. FireBase 연동 코드 mixin 활용하여 코드를 일반화하였습니다.
3. 모든 데이터는 riverpod을 이용하여 저장/정제/생성 이용하였습니다.
4. 지속적으로 develop 되었습니다.
(setState, FutureBuilder => Provider => Riverpod)
5. 이미지 캐싱
(이미지 크기로 인하여 바로 출력이 안되면 해당 이미지에 대한 로딩 화면이 나타나도록 하였습니다.)


