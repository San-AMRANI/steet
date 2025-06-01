import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:steet/domain/entities/student.dart';
import 'package:steet/presentation/providers/prv_room_provider.dart';
import 'package:steet/presentation/widgets/my_text_field.dart';
import 'package:steet/presentation/widgets/my_text_icon_button.dart';
import 'package:steet/presentation/rooms/widgets/search_members_dialog.dart';

class CreateRoomPage extends ConsumerStatefulWidget {
  final bool isAdmin;
  const CreateRoomPage({super.key, required this.isAdmin});

  @override
  ConsumerState<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends ConsumerState<CreateRoomPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isVisible = true;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  List<Student> selectedMembers = [];

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _onCreateRoom() {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    if (nameController.text.isEmpty || descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }
    ref.read(createPrvRoomProvider.notifier).createRoomAndSendInvitations(
          name: nameController.text,
          description: descriptionController.text,
          isVisible: isVisible,
          createdBy:
              'c8d6618f-0b4c-4897-bb99-45d93d304f41', // Replace with actual user ID
          imagePath: _imageFile!.path,
          invitedMembers: selectedMembers.map((s) => s.id).toList(),
        );
  }

  void _onInviteMembers() async {
    await showDialog<void>(
      context: context,
      builder: (context) => SearchMembersDialog(
        initialSelection: selectedMembers,
        onMembersSelected: (members) {
          setState(() {
            selectedMembers = members;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(createPrvRoomProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          if (data != null) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Room created successfully')),
            );
          }
        },
        error: (error, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to create room: $error')),
          );
        },
      );
    });

    final createRoomState = ref.watch(createPrvRoomProvider);
    final isLoading = createRoomState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: _imageFile == null
                  ? Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const Center(
                        child: Icon(Icons.add_a_photo,
                            size: 40, color: Colors.grey),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(_imageFile!,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover),
                    ),
            ),
            const SizedBox(height: 20),
            MyTextField(
              labelText: 'Room Name',
              hintText: 'Enter room name',
              controller: nameController,
              obscureText: false,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            MyTextField(
              labelText: 'Description',
              hintText: 'Enter room description',
              controller: descriptionController,
              obscureText: false,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 20),
            if (selectedMembers.isEmpty)
              MyTextIconButton(
                text: 'Invite Members',
                prefixIcon: Icons.person_add,
                onPressed: _onInviteMembers,
              )
            else
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...selectedMembers.map((member) => Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.2),
                            backgroundImage: member.imageUrl != null
                                ? NetworkImage(member.imageUrl!)
                                : null,
                            child: member.imageUrl == null
                                ? Text(
                                    member.firstName[0].toUpperCase(),
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : null,
                          ),
                        )),
                    // Add button at the end of the list
                    GestureDetector(
                      onTap: _onInviteMembers,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        child: Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            if (!widget.isAdmin) ...[
              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Visible to others'),
                    Switch(
                      value: isVisible,
                      onChanged: (val) {
                        setState(() {
                          isVisible = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 16),
            ],
            const Spacer(),
            Stack(
              alignment: Alignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  onPressed: isLoading ? null : _onCreateRoom,
                  child:
                      const Text('Create Room', style: TextStyle(fontSize: 16)),
                ),
                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
