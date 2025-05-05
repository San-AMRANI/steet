//? here I defined the operations for the graphql queries and mutations Like a schema

class GraphQLOperations {

  static const String getStudents = '''
    query GetStudents() {
      Students {
        id
        firstName
        lastName
        userName
        email
        dob
        major
      }
    }
  ''';

  static const String getStudentById = '''
    query GetStudentById(\$id: ID!) {
      Student(id: \$id) {
        id
        firstName
        lastName
        userName
        email
        dob
        major
      }
    }
  ''';

  static const String getStudentByEmail = '''
    query GetStudentByEmail(\$email: String!) {
      StudentByEmail(email: \$email) {
        id
        firstName
        lastName
        userName
        email
        dob
        major
      }
    }
  ''';

  static const String getStudentByUsername = '''
    query GetStudentB userName(\ userName: String!) {
      StudentB  userName: \ userName) {
        id
        firstName
        lastName
        userName
        email
        dob
        major
      }
    }
  ''';

  static const String getPublicRooms = '''
    query GetPublicRooms() {
      pubRooms() { 
        id
        name
        description
        participantsCount
      }
    }
  ''';

}