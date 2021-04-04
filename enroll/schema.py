import graphene
from graphene_django import DjangoObjectType
from django.contrib.auth import get_user_model
from graphql_auth.schema import UserQuery, MeQuery


class UserNode(DjangoObjectType):
    class Meta:
        model = get_user_model()


class Query(UserQuery, MeQuery, graphene.ObjectType):
    pass


# class MyMutations(graphene.ObjectType):
#     pass


schema = graphene.Schema(query=Query)  # , mutation=MyMutations)
