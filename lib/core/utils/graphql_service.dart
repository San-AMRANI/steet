// import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  static GraphQLService? _instance;
  late final GraphQLClient _client;
  
  // Your GraphQL server URL
  final String _graphQLEndpoint = 'http://192.168.31.184:8008/graphql';
  GraphQLService._() {
  // print('GraphQL endpointhhhhhhhhhhhhhhhhhhhh: $_graphQLEndpoint');
    final HttpLink httpLink = HttpLink(_graphQLEndpoint);
    
    final Link link = httpLink;

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