from django.shortcuts import render

# Create your views here.
def throw(request):
    return render(request,'throw/throw.html')

def catch(request):
    print(request)
    message = request.GET.get('message')
    context = {
        'message':message,
    }
    return render(request, 'catch/catch.html', context)