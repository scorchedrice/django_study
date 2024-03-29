from django.shortcuts import render, redirect
from .models import CRUDS

# Create your views here.
def index(request):
    info = CRUDS.objects.all()
    context = {
        'info' : info,
    }
    return render(request, 'cruds/index.html', context)

def detail(request, pk):
    crud = CRUDS.objects.get(pk=pk)
    # pk를 통해 값을 구분한다. 좌측의 pk와 우측의 pk는 이름만 같고 연관이 없다.
    context = {
        'crud':crud,
    }
    return render(request, 'cruds/detail.html',context)

def new(request):
    return render(request,'cruds/new.html')

def create(request):
    print(request.POST)
    title = request.POST.get('title')
    content = request.POST.get('content')
    # request를 받고 이를 DB에 등록하는 과정 (POST)
    cruds = CRUDS()
    cruds.title = title
    cruds.content = content
    cruds.save()
    
    return redirect('cruds:detail',cruds.pk)
    # redirect할 주소, 변수값

def delete(request,pk):
    cruds = CRUDS.objects.get(pk=pk)
    cruds.delete()
    return redirect('cruds:index')

def update(request,pk): # edit.html에서 수정한 정보를 DB에 반영하기 위함.
    cruds = CRUDS.objects.get(pk=pk)

    title = request.POST.get('title')
    content = request.POST.get('content')
    
    cruds.title = title
    cruds.content = content
    cruds.save()
    return redirect('cruds:index')

def edit(request,pk):
    cruds = CRUDS.objects.get(pk=pk)
    context = {
        'cruds':cruds,
    }
    return render(request,'cruds/edit.html',context)