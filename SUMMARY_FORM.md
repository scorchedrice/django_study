# FORM
## 기존에 사용하던 FORM
- HTML에서는 사용자로부터 데이터를 받기위해 활용한 방법
- 하지만, 비정상적 / 악의적인 요청을 필터링 할 수 없다는 단점을 가지고 있다.
    - 유효한 데이터 확인 필요!
## 유효성 검사
- 입력 값/형식/중복/범위/보안 등을 고려한 django 제공 form을 이용해 유효성을 검사 할 수 있다.
- Class 로 구성되어 있다.

### django form 구현
```python
from django import forms

class ArticleForm(forms.Form):
    title = forms.CharField(max_length=10)
    content = forms.CharField(widget=forms.Textarea)
```
- forms.py파일을 앱 내에 생성한 후 위 과정을 진행한다.
- 이렇게 forms.py를 생성하고 view함수 및 html을 수정하면 django에서 제공하는 form을 사용할 수 있다.
- 하지만, 이 경우엔 유효성 검사를 진행한 과정은 아님

### ModelForm
- 일반 Form : DB에 저장하지 않을 때, 주로 활용 (로그인)
- ModelForm : 사용자 입력 데이터를 DB에 저장해야 할 때 (회원가입, 게시글 작성 ..)

### forms.py에서 models.py정보를 가져와 django form을 구현하는 방법
- Meta class 활용
    ```python
    from .models import Article

    class ArticleForm(forms.ModelForm):
        # models.py에서 정의한 class를 가져오는 것.
        class Meta:
            model = Article
            # 어떤 모델과 연동할 것이냐
            fields = '__all__'
            # 그 모델에서 어떤 필드를 쓸 것이냐 (__all__ : 모든 필드를 가져온다)
            # 만약 모두 가져오는 것이 아닌 일부만 가져오고 싶다면?
            '''
            fields = ('title','content')
            '''
            # 일부를 제외하고 가져오고 싶다면?
            '''
            exclude = ('title')
            '''
    ```
### is_valid()의 특징, 활용
- 이 값이 유효한지 True, False로 값을 도출해준다.
    - False인 경우 무슨 에러인지도 나타내준다.
```python
def create(request):
    form = ArticleForm(request.POST)
    if form.is_valid(): # 유효성 검사 (True라면 ,,)
        article = form.save()
        return redirect('articles:detail',article.pk)
    # 유효성 검사를 통과 못하면, form 파일에 통과 못한 이유를 함께 저장해줌
    # 따라서 이 정보를 그대로 가져오면, 에러 원인을 출력함.
    context = {
        'form':form,
    }
    # False 인 경우
    return render(request,'articles/new.html',context)
```
- 여기서 False인 경우, return render ... 을 하는 이유
    - render vs. redirect
        - redirect : 사용자에게 해당 명령을 **한번 더 보내도록** 함
        - render : 해당 명령을 수행함.
    - 한번더 보내기에, is_valid()를 활용해 에러 메세지를 출력하기 위해선 redirect가 아닌 render을 활용해야 한다.

## 함수 구조화 (두개의 view 함수 한개의 함수로)
- data를 받는 방식이 POST이냐, 그 외의 방식이냐를 if문을 활용해 하나의 함수에서 구현할 수 있다.
- example1. new + create
    ```python
    def create(request):
    form = ArticleForm(request.POST)
    if request.method == 'POST': # Post면 create
        if form.is_valid(): # 유효성 검사 (True라면 ,,)
            article = form.save()
            return redirect('articles:detail',article.pk)
        
    else: # POST가 아니므로 ArticleForm()
        # POST 외의 것을 아래와 같은 조작을 해야하므로, POST를 조건으로 거는 것이 좋음.
        form = ArticleForm()
    
    # is_valid == False or method != POST, 들여쓰기 주의!
    context = {
        'form':form,
    }
    return render(request, 'articles/create.html',context)
    ```

- example2. edit + update
    ```python
    def update(request,pk):
    article = Article.objects.get(pk=pk)
    if request.method == 'POST':
        form = ArticleForm(request.POST, instance=article)
        if form.is_valid():
            form.save()
            return redirect('articles:detail', article.pk)
    else:
        form = ArticleForm(instance=article)
    context = {
        'article': article,
        'form':form,
    }
    return render(request, 'articles/edit.html', context)
    ```
- 이와 같은 과정을 거치고, urls.py, .html파일 등을 알맞게 수정해야 한다.

