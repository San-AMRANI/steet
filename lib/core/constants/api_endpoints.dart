class ApiEndpoints {

  //! ==================== Student Management Endpoints ========================================

  // Student endpoints
  static const String students = '/api/students';
  /// GET: Retrieve all students
  /// Returns a list of all students in the system
  
  static const String studentById = '/api/students/{id}';
  /// GET: Retrieve a student by their ID
  /// Path param: id - UUID of the student
  
  static const String studentByEmail = '/api/students/email/{email}';
  /// GET: Retrieve a student by their email
  /// Path param: email - Email of the student
  
  static const String studentByUsername = '/api/students/username/{userName}';
  /// GET: Retrieve a student by their username
  /// Path param: userName - Username of the student
  
  static const String uploadProfileImage = '/api/students/upload-profile-image';
  /// POST: Upload a profile image for a student.
  /// Params: studentId (form field, UUID), file (form field, image file)

  static const String getProfileImage = '/api/students/profile-image/{fileName}';
  /// GET: Retrieve a profile image by its file name.
  /// Params: fileName (path variable)

  static const String createUpdateStudent = '/api/students';
  /// POST: Create a new student
  /// Body: Student object
  /// PUT: Update an existing student
  /// Body: Student object with ID
  
  static const String deleteStudent = '/api/students/{id}';
  /// DELETE: Delete a student by ID
  /// Path param: id - UUID of the student
  
  // Administrator endpoints
  static const String admins = '/api/admins';
  /// GET: Retrieve all administrators
  
  static const String adminById = '/api/admins/{id}';
  /// GET: Retrieve an administrator by ID
  /// Path param: id - UUID of the administrator
  
  static const String createAdmin = '/api/admins';
  /// POST: Create a new administrator
  /// Body: Administrator object
  
  static const String updateAdmin = '/api/admins/{id}';
  /// PUT: Update an administrator
  /// Path param: id - UUID of the administrator
  /// Body: Administrator object
  
  static const String deleteAdmin = '/api/admins/{id}';
  /// DELETE: Delete an administrator
  /// Path param: id - UUID of the administrator
  
  // User endpoints
  static const String users = '/api/users';
  /// Endpoints for general user operations
  

  //! ==================== Room Management Endpoints ========================================
  
  // General Room endpoints
  static const String rooms = '/rooms';
  /// GET: Retrieve all rooms (both public and private)
  
  static const String roomById = '/rooms/{id}';
  /// GET: Retrieve a room by ID
  /// Path param: id - UUID of the room
  /// POST: Create a new room
  /// Body: Room object
  /// PUT: Update a room
  /// Path param: id - UUID of the room
  /// Body: Room object
  /// DELETE: Delete a room
  /// Path param: id - UUID of the room
  
  // Public Room endpoints
  static const String allPublicRooms = '/roomsAdmin/allPublicRooms';
  /// GET: Retrieve all public rooms
  
  static const String publicRoomById = '/roomsAdmin/publicRoomById';
  /// GET: Retrieve a public room by ID
  /// Query param: id - UUID of the public room
  
  static const String createPublicRoom = '/roomsAdmin/createPublicRoom';
  /// POST: Create a new public room
  /// Body: PubRoom object
  
  static const String updatePublicRoom = '/roomsAdmin/updatePublicRoom';
  /// POST: Update a public room
  /// Query param: id - UUID of the public room
  /// Body: PubRoom object with updated fields
  
  static const String deletePublicRoom = '/roomsAdmin/deletePublicRoom';
  /// DELETE: Delete a public room
  /// Query param: id - UUID of the public room
  
  // Private Room endpoints
  static const String privateRooms = '/privateRooms';
  
  static const String createPrivateRoom = '/privateRooms/create';
  /// POST: Create a new private room
  /// Body: PrvRoom object
  
  static const String createStudentPrivateRoom = '/privateRooms/student/create';
  /// POST: Create a private room for a student
  /// Query params:
  /// - studentId: UUID of the student creating the room
  /// - name: Name of the room
  /// - description: (optional) Description of the room
  /// - imageUrl: (optional) URL for the room image
  /// - isVisible: (optional, default=false) Whether the room is visible
  
  static const String updatePrivateRoom = '/privateRooms/update/{id}';
  /// PUT: Update a private room
  /// Path param: id - UUID of the private room
  /// Body: PrvRoom object with updated fields
  
  static const String deletePrivateRoom = '/privateRooms/delete/{id}';
  /// DELETE: Delete a private room
  /// Path param: id - UUID of the private room
  
  static const String privateRoomById = '/privateRooms/{id}';
  /// GET: Retrieve a private room by ID
  /// Path param: id - UUID of the private room
  
  static const String allPrivateRooms = '/privateRooms/all';
  /// GET: Retrieve all private rooms
  
  static const String visiblePrivateRooms = '/privateRooms/visible';
  /// GET: Retrieve all visible private rooms
  
  static const String updateRoomVisibility = '/privateRooms/{id}/visibility';
  /// PUT: Update the visibility of a private room
  /// Path param: id - UUID of the private room
  /// Query params:
  /// - isVisible: Boolean indicating whether the room should be visible
  /// - studentId: UUID of the student making the request (must be creator)
  
  static const String privateRoomsByCreator = '/privateRooms/creator/{studentId}';
  /// GET: Retrieve all private rooms created by a student
  /// Path param: studentId - UUID of the student
  
  // Student Room Management endpoints
  static const String studentRooms = '/student/rooms';
  
  static const String createStudentRoom = '/student/rooms/private/create';
  /// POST: Create a private room for a student
  /// Query params:
  /// - studentId: UUID of the student creating the room
  /// - roomName: Name of the room
  /// - description: (optional) Description of the room
  /// - imageUrl: (optional) URL for the room image
  /// - isVisible: (optional, default=false) Whether the room is visible
  
  static const String studentRoomInfo = '/student/rooms/{studentId}';
  /// GET: Retrieve all room information for a student
  /// Path param: studentId - UUID of the student
  /// Returns: StudentRoomsDTO with created rooms, member rooms, and pending invitations
  
  static const String inviteStudentToRoom = '/student/rooms/invite';
  /// POST: Invite a student to a private room
  /// Query params:
  /// - roomId: UUID of the room
  /// - invitedStudentId: UUID of the student being invited
  /// - invitingStudentId: UUID of the student sending the invitation
  
  static const String leavePrivateRoom = '/student/rooms/leave';
  /// POST: Leave a private room
  /// Query params:
  /// - roomId: UUID of the room
  /// - studentId: UUID of the student leaving the room
  
  // Membership endpoints
  static const String memberships = '/memberships';
  
  static const String createMembership = '/memberships/create';
  /// POST: Create a new membership
  /// Body: Membership object
  
  static const String updateMembership = '/memberships/update/{id}';
  /// PUT: Update a membership
  /// Path param: id - UUID of the membership
  /// Body: Membership object with updated fields
  
  static const String deleteMembership = '/memberships/delete/{id}';
  /// DELETE: Delete a membership
  /// Path param: id - UUID of the membership
  
  static const String membershipById = '/memberships/{id}';
  /// GET: Retrieve a membership by ID
  /// Path param: id - UUID of the membership
  
  static const String allMemberships = '/memberships/all';
  /// GET: Retrieve all memberships
  
  static const String membershipsByStudentId = '/memberships/student/{studentId}';
  /// GET: Retrieve all memberships for a student
  /// Path param: studentId - UUID of the student
  
  static const String membershipsByRoomId = '/memberships/room/{roomId}';
  /// GET: Retrieve all memberships for a room
  /// Path param: roomId - UUID of the room
  
  // Participation endpoints
  static const String participations = '/participations';
  
  static const String allParticipations = '/participations/all';
  /// GET: Retrieve all participations
  
  static const String participationsByStudentId = '/participations/student/{studentId}';
  /// GET: Retrieve all participations for a student
  /// Path param: studentId - UUID of the student
  
  static const String participationsByRoomId = '/participations/room/{roomId}';
  /// GET: Retrieve all participations for a room
  /// Path param: roomId - UUID of the room
  
  // Invitation endpoints
  static const String invitations = '/invitations';
  
  static const String sendInvitation = '/invitations/send';
  /// POST: Send an invitation to a student
  /// Query params:
  /// - roomId: UUID of the room
  /// - invitedStudentId: UUID of the student being invited
  /// - inviterId: UUID of the student sending the invitation
  
  static const String acceptInvitation = '/invitations/accept';
  /// POST: Accept an invitation
  /// Query params:
  /// - roomId: UUID of the room
  /// - studentId: UUID of the student accepting the invitation
  
  static const String rejectInvitation = '/invitations/reject';
  /// POST: Reject an invitation
  /// Query params:
  /// - roomId: UUID of the room
  /// - studentId: UUID of the student rejecting the invitation
  
  static const String pendingInvitations = '/invitations/pending/{studentId}';
  /// GET: Retrieve pending invitations for a student
  /// Path param: studentId - UUID of the student
}