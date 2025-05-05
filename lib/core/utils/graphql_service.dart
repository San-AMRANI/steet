// import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  static GraphQLService? _instance;
  late final GraphQLClient _client;
  
  // Your GraphQL server URL
  final String _graphQLEndpoint = 'http://your-server-url/graphql';
  
  GraphQLService._() {
    final HttpLink httpLink = HttpLink(_graphQLEndpoint);
    
    // If you need authentication
    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer <your-token>', // Replace with your auth token logic
    );
    
    final Link link = authLink.concat(httpLink);
    
    _client = GraphQLClient(
      link: link,
      cache: GraphQLCache(),
    );
  }
  
  factory GraphQLService() {
    _instance ??= GraphQLService._();
    return _instance!;
  }
  
  GraphQLClient get client => _client;
  
  // Execute a query
  Future<QueryResult> query(String queryString, {Map<String, dynamic>? variables}) async {
    final QueryOptions options = QueryOptions(
      document: gql(queryString),
      variables: variables ?? {},
    );
    
    return await _client.query(options);
  }
  
  // Execute a mutation
  Future<QueryResult> mutate(String mutationString, {Map<String, dynamic>? variables}) async {
    final MutationOptions options = MutationOptions(
      document: gql(mutationString),
      variables: variables ?? {},
    );
    
    return await _client.mutate(options);
  }
}