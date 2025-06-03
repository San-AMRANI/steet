import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/presentation/notifications/widgets/notification_item.dart';
import 'package:steet/presentation/providers/invitation_provider.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invitationsAsync = ref.watch(invitationProvider);
    final invitationState = ref.watch(invitationOperationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Invitations'),
      ),
      body: invitationsAsync.when(
        data: (invitations) {
          if (invitations.isEmpty) {
            return const Center(
              child: Text('No pending invitations'),
            );
          }

          return Stack(
            children: [
              ListView.builder(
                itemCount: invitations.length,
                itemBuilder: (context, index) {
                  final invitation = invitations[index];
                  return NotificationItem(
                    invitation: invitation,
                    onAccept: () async {
                      try {
                        final success = await ref
                            .read(invitationOperationsProvider.notifier)
                            .acceptInvitation(invitation);
                        
                        if (success) {
                          // Refresh the invitations list
                          ref.refresh(invitationProvider);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Invitation accepted')),
                            );
                          }
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to accept invitation'),
                              ),
                            );
                          }
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $e')),
                          );
                        }
                      }
                    },
                    onDecline: () async {
                      try {
                        final success = await ref
                            .read(invitationOperationsProvider.notifier)
                            .rejectInvitation(invitation);
                            
                        if (success) {
                          // Refresh the invitations list
                          ref.refresh(invitationProvider);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Invitation declined')),
                            );
                          }
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to decline invitation'),
                              ),
                            );
                          }
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $e')),
                          );
                        }
                      }
                    },
                  );
                },
              ),
              if (invitationState.isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
} 