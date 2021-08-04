# StageUs_3th_WebBasic_OutsourcingSimulation
### 스테이지어스 3기 웹기초 모의외주 프로젝트 
<br>

## Project Name
### TODO TODAY
## Develop Period
#### 2021.07.24 ~ 2021.08.02
## Contributor
#### Shin JeongMin
<br>

## Develop Info
|Develop Langauge|Server|WAS|DB|
|-|-|-|-|
|HTML, CSS, JS, JSP|AWS|Tomcat|MariaDB|

### Consideration
#### 고려한 부분
로그인 이후 사용자 정보를 계속 유지하는 시스템을 구현하기 위하여 세션기술을 적용
data base에 접근하여 query 결과를 가져오는 부분과 프론트엔드 부분을 분리하여 상호작용하는 구조를 만들기 위해서, 
JSP 페이지를 DB data를 가져오는 부분만을 독립적으로 모듈화하고, 데이터 처리 및 동적 DOM 생성 동작들을 JS에서 처리하도록 구성.
프론트 엔드와 백엔드가 서로 분리되어 필요 부분만을 상호작용시키는 구조로 프로젝트 구현


# Web Page Preview
#### Main Schedule Page
![image](https://user-images.githubusercontent.com/52451400/128207761-91378b40-5c2a-4603-a385-1b022f7b2ade.png)
## Flexible Web
![FlexibleWeb_Project_Scheduler_ShinJeongMin](https://user-images.githubusercontent.com/52451400/128212996-9040b8c0-717c-49af-89bd-b75fac23c014.gif)

## Can view each month's schedules
![ChangeMonth_Project_Scheduler_ShinJeongMin](https://user-images.githubusercontent.com/52451400/128217940-1d1de39c-02d7-45b9-a846-8a97e53830b2.gif)


#### Create Schedule Page
![image](https://user-images.githubusercontent.com/52451400/128208360-1b522971-d2c1-417e-8b99-e1aa922ad151.png)

#### Modify Schedule Page
![image](https://user-images.githubusercontent.com/52451400/128208141-cb681b7c-8f6b-4808-868b-ec74159ee985.png)

