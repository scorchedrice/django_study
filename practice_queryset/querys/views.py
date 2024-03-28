from django.shortcuts import render
from .models import Query

# Create your views here.
def index(request):
    memory = Query.objects.all()
    print(memory)
    context = {
        'memory' : memory
    }
    return render(request,'querys/index.html',context)