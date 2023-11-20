from django.urls import path, include

from rest_framework.routers import DefaultRouter
from .views import TodoViewSet, UserRegistrationViewSet
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView, TokenVerifyView

router = DefaultRouter()
router.register('todos', TodoViewSet, basename='todos')

urlpatterns = [
    path("register/", UserRegistrationViewSet.as_view(), name="register-user"),
    path('token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('token/verify/', TokenVerifyView.as_view(), name='token_verify'),
    path("get-todos/", TodoViewSet.as_view({"get": "user_todos"}), name="get-todos"),
    path("", include(router.urls)),
]
