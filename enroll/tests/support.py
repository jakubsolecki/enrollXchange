from django.contrib.auth import get_user_model
from django.test.testcases import TestCase

from enroll.schema.schema import schema
from enroll.models import UserType

from graphene.test import Client
from graphql_relay import to_global_id


def get_global_id(object_type, instance):
    return to_global_id(object_type._meta.name, instance.id)


class ConnectionTestCase(TestCase):
    def setUp(self):
        super().setUp()
        self.client = Client(
            schema=schema,
        )
        self.user = get_user_model().objects.create(
            username="test_user", user_type=UserType.get_by_name("student")
        )

    @staticmethod
    def get_context(context_user):
        class TestContext:
            user = context_user

        return TestContext

    def parse_result(self, result):
        if "data" in result and result["data"]:
            result["data"] = dict(result["data"])
        return result

    def run_query(self, query, variables=None, context=None, user=None):
        if not variables:
            variables = {}
        if context:
            return self.client.execute(query, variables=variables, context=context)
        if user:
            return self.client.execute(
                query, variables=variables, context=ConnectionTestCase.get_context(user)
            )
        return self.client.execute(query, variables=variables)

    def execute(self, query, variables=None, context=None, user=None):
        result = self.run_query(query, variables=variables, context=context, user=user)
        return self.parse_result(result)
