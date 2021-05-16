from django.test.testcases import TestCase
from enroll.schema.schema import schema

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

    @staticmethod
    def get_context(context_user):
        class TestContext:
            user = context_user

        return TestContext

    def execute(self, query, variables=None, context=None, user=None):
        if not variables:
            variables = {}
        if context:
            return self.client.execute(query, variables=variables, context=context)
        if user:
            return self.client.execute(
                query, variables=variables, context=ConnectionTestCase.get_context(user)
            )
        return self.client.execute(query, variables=variables)
