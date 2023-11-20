from django.contrib.auth.hashers import make_password
from django.contrib.auth.models import User
from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

from todos import models
from todos.serializers import TodoSerializer


class TodoViewSet(viewsets.ModelViewSet):
    serializer_class = TodoSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return models.Todo.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

    @action(detail=False, methods=["GET"])
    def user_todos(self, request):
        todos = models.Todo.objects.filter(user=request.user)
        serializer = self.get_serializer(todos, many=True)
        return Response(serializer.data)


class UserRegistrationViewSet(APIView):

    @staticmethod
    def post(request):
        data = request.data

        mandatory_data = ["username", "password"]
        mandatory_data_check = [d in data for d in mandatory_data]
        if all(mandatory_data_check):
            username = data["username"]
            password = data["password"]
            masked_password = make_password(password)

            if User.objects.filter(username=username).exists():
                return Response({"detail": "Username not available"}, status=status.HTTP_400_BAD_REQUEST)

            new_user = User(username=username, password=masked_password)
            new_user.save()
            return Response({"detail": "User successfully created"}, status=status.HTTP_201_CREATED)

        missing_fields = [mandatory_data[i] for i, c in enumerate(mandatory_data_check) if c]
        return Response({"detail": f"Missing field{'s' if len(missing_fields) > 1 else ''}: [{missing_fields}]"},
                        status=status.HTTP_400_BAD_REQUEST)
