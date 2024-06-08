from promptflow import tool
from promptflow.connections import CustomConnection
from azure.core.credentials import AzureKeyCredential
from azure.search.documents import SearchClient
from azure.search.documents.models import VectorizedQuery

@tool
def my_python_tool(vector: list, ai_conn: CustomConnection) -> list:
    ai_conn_dict = dict(ai_conn)
    endpoint = ai_conn_dict['endpoint']
    key = ai_conn_dict['key2']
    index = ai_conn_dict['index']

    # query azure ai search
    credential = AzureKeyCredential(key)
    client = SearchClient(endpoint=endpoint,
                          index_name=index,
                          credential=credential)
    vector_query = VectorizedQuery(vector=vector, k_nearest_neighbors=3, fields="content_vector", exhaustive=True)
    results = client.search(
        search_text=None,
        vector_queries=[vector_query],
        select=["content", "source", "metadata"]
    )

    # convert results to json list
    results = [dict(result) for result in results]

    return results