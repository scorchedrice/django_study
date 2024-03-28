# ORM
- Django, DB간 다른 언어를 극복하고 소통하기 위함.

## QuerySet API
- ORM에서 데이터를 검색/필터링/정렬/그룹화 할 때 활용
- API를 사용해 SQL이 아닌 python 코드로 데이터를 처리
```python
Article.objects.all()
#Modelclass.Manager.QuerysetAPI 꼴
```
- python의 모델 클래스와 인스턴스를 활용해 DB에 데이터를 저장/조회/수정/삭제 하는 것

### QuerySet API를 사용하기 위한 사전준비
- pip install django-extensions
- pip install ipython
- setting.py에 생성한 앱과 django_extentions를 추가

## Django Shell
- django 환경에서 실행되는 python shell
- python manage.py shell_plus 로 실행
### 데이터 객체를 만드는 방법들
- 우선 models.py 에 그림이 그려져 있어야 함.
1. 첫번째
```python
article = Article() # Article(class)로 부터 article(instance) 생성
# article ... <Article:Article object(None)>
article.title = '~~'
article.content = '!!'
#article.objects.all() ... <QuerySet []>
article.save() # 이를 해야 저장된 것을 확인 가능
```
2. 두번째
```python
article = Article(title = '~~~', content='!!')
# instance 설정과 등록을 동시에
article.save()
```

3. create사용
```python
article = Article()
Article.objects.create(title='~~',content='!!')
```

### all(), filter(), get()
#### all()
- 전체 데이터 조회
```python
Article.objects.all()
```
#### filter()
- 특정 조건 데이터 조회
```python
Article.objects.filter(content = 'abc')
```
#### get()
- 단일 데이터 조회, 단 고유성을 보장하는 조회에서 활용해야 한다. (둘 이상의 객체 : MultipleObjectReturned 에러)
```python
Article.objects.get(pk=1)
```

# 실제로 적용하기 (Shell을 통한 데이터 수정, html파일에 표시)
1. django, django-extensions, ipython 설치
2. django-extensions / 앱 등록과정 필요 (settings.py)
3. urls > views > templates/.html 과정을 거친다.
4. models.py에 class를 정의한다. (DB의 틀을 잡기 위함)
    - 틀을 잡은 이후에, python manage.py makemigrations, python manage.py migrate 과정 필
5. Shell을 통한 데이터를 추가 및 수정을 진행한다.
6. views파일을 확인한다. 여기서 다음의 과정을 추가한다.
```python
from .models import Query
# Query는 models.py에서 정의한 class
'''
Query.objects.all() 등의 방법으로 데이터를 받는다.
그리고 context에 값을 추가하고 render 마지막 변수로 context를 추가한다.
'''
```
