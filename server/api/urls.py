
from django.urls import path
from api.views import user_views

urlpatterns = [
        # user login, logout and registration url
    path('login/', user_views.login_view),
    path('registration/', user_views.signup_view),
]
