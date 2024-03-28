from django.shortcuts import render
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