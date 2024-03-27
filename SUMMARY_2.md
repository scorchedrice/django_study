## templates - .html 내 콘텐츠를 변수 값에 따라 바꾸고 싶다면
- views.py 내 정의한 함수 내부에 context라는 dict. 생성하여 활용한다. (return render ... 부분에 3번째 변수로 context가 사용되어야 한다.)
    ![Alt text](image-4.png)
- html 내에는 {{ 변수 }} 꼴로 이를 활용한다. (|을 사용하여 길이 표현, for tag 등 사용해서 반복문 사용 등 추가기능 존재)
    ![Alt text](image-5.png)

## template 상속 방법 - form tag 활용
- 여러개의 html을 연결할 때, 모두 같은 html code를 작성해야 할까? 그냥 넘기는 방법은 없을까?
```django
<!-- skeleton 역할을 하게 되는 상위 템플릿에서 .. -->
{% block content %}
{% endblock content %}

<!-- 하위 템플릿에서 ... -->
{% extends '상위template주소/이름.html'}
<!-- 어떤 부모의 템플릿을 상속 받을 것이냐 -->

{% block content %}
{% endblock content %}
```
- 하위 템플릿이 부모 템플릿을 확장하기 위해 extends tag 활용한다. (두개 이상 사용 불가)
- 상위 템플릿에서 block tag를 통해 하위 템플릿이 작성할 수 있는 공간을 지정한다.
- block에 이름을 설정해 여러개의 블럭을 생성하고, 이를 활용할 수 있다.

## HTML 요청과 응답
- form은 http 요청을 서버에 보내는 편리한 방법
    - 로그인, 검색, 체크박스 등에 활용
    - 데이터를 어디로 보낼까 (목적지 설정 안하면, 현재 form이 있는 페이지의 url로 보내짐)

## Action & Method
- 어떤 방식으로 보낼 것인가
- GET(URL노출), POST(로그인 - 보안문제이기에 POST사용)

## Throw and Catch 파일 매커니즘
1. project를 생성하고 어플을 만드는 것 까진 일반적인 상황과 동일
2. url을 설정한다 (throw 와 catch)
3. view를 설정한다. (def throw , def catch)
    - 단 catch의 경우 주어지는 데이터를 받는 과정이 필요하다.
    - request.GET.get('~~')을 활용해 throw에서 던진 데이터를 받는 과정이 필요하다.
    - 이 데이터를 context로 구성해서 render하도록 한다.
4. 앱의 templates를 생성한다.
    - throw의 경우엔 데이터를 넘길 수 있도록 해야한다.
    ```python
    <form action="/articles/catch/" method="GET">
        <input type="text" id="message" name="message">
        <input type="submit">
    </form>
    ```
    - catch의 경우엔 {{ 받을 것 }} 을 활용해 데이터를 받고 출력한다.

### form
- 형태 : <form action = "경로" method = "어떤 매소드">
    - action : 폼을 전송할 서버 쪽 스크립트 파일 지정
    - name : 폼 식별 목적
    - method : 폼을 서버에 전송할 htt 매소드를 정한다. (GET, POST)