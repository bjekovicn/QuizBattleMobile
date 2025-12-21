import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizcleandemo/injection.dart';
import 'package:quizcleandemo/ui/friend_battle_lobby/bloc/friend_battle_lobby_bloc.dart';
import 'package:quizcleandemo/ui/friend_battle_lobby/bloc/friend_battle_lobby_events.dart';
import 'package:quizcleandemo/ui/friend_battle_lobby/bloc/friend_battle_lobby_state.dart';

import '/data/game/domain/entities/game/invite_status.dart';

import '/ui/shared/widgets/user/common_user_tile.dart';
import '/ui/friends/state/friends_bloc.dart';
import '/ui/friends/state/friends_event.dart';
import '/ui/friends/state/friends_state.dart';

class FriendBattleLobbyScreen extends StatelessWidget {
  final String languageCode;
  final String? roomId; // Optional - if set, join existing room

  const FriendBattleLobbyScreen({
    super.key,
    required this.languageCode,
    this.roomId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<FriendBattleLobbyBloc>()
            ..add(roomId != null
                ? JoinExistingRoomEvent(roomId: roomId!)
                : CreateFriendRoomEvent(languageCode: languageCode)),
        ),
        BlocProvider(
          create: (_) => getIt<FriendsBloc>()..add(GetFriendsEvent()),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Friend Battle Lobby'),
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  context
                      .read<FriendBattleLobbyBloc>()
                      .add(const LeaveLobbyEvent());
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          body: BlocConsumer<FriendBattleLobbyBloc, FriendBattleLobbyState>(
            listener: (context, state) {
              if (state.status == LobbyStatus.error &&
                  state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );
              }
            },
            builder: (context, lobbyState) {
              if (lobbyState.status == LobbyStatus.creating) {
                return const Center(child: CircularProgressIndicator());
              }

              if (lobbyState.status == LobbyStatus.error) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(lobbyState.errorMessage ?? 'Error creating room'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Go Back'),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  // Room Info Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    color: Colors.grey[200],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Room: ${lobbyState.roomId ?? 'N/A'}',
                            style: const TextStyle(fontSize: 12)),
                        Text('Players: ${lobbyState.players.length}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),

                  // Players + Invites (Top Half)
                  Expanded(
                    flex: 1,
                    child: _PlayersAndInvitesSection(state: lobbyState),
                  ),

                  const Divider(height: 1, thickness: 2),

                  // Friends List (Bottom Half) - Only for Host
                  if (lobbyState.isHost)
                    Expanded(
                      flex: 1,
                      child: _FriendsListSection(lobbyState: lobbyState),
                    ),

                  // Start Game Button
                  if (lobbyState.isHost)
                    _StartGameButton(state: lobbyState)
                  else
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: const Text(
                        'Waiting for host to start game...',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// Players + Invites Section (Top)
class _PlayersAndInvitesSection extends StatelessWidget {
  final FriendBattleLobbyState state;

  const _PlayersAndInvitesSection({required this.state});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Players
        const Text('Players:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...state.players.map((player) => Card(
              child: ListTile(
                leading: player.photoUrl != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(player.photoUrl!))
                    : const CircleAvatar(child: Icon(Icons.person)),
                title: Text(player.displayName),
                subtitle: Text('ID: ${player.userId}'),
                trailing: player.userId == state.hostUserId
                    ? const Chip(label: Text('Host'))
                    : null,
              ),
            )),

        if (state.isHost) ...[
          const SizedBox(height: 24),
          const Text('Invites:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (state.invites.isEmpty)
            const Text('Tap a friend below to invite',
                style: TextStyle(color: Colors.grey))
          else
            ...state.invites.map((invite) => Card(
                  child: ListTile(
                    leading: invite.invitedPhotoUrl != null
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage(invite.invitedPhotoUrl!))
                        : const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(invite.invitedDisplayName),
                    trailing: _InviteStatusChip(status: invite.status),
                  ),
                )),
        ],
      ],
    );
  }
}

// Friends List Section (Bottom) - For inviting
class _FriendsListSection extends StatelessWidget {
  final FriendBattleLobbyState lobbyState;

  const _FriendsListSection({required this.lobbyState});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: Colors.grey[100],
          child: const Text(
            'Tap a friend to invite:',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: BlocBuilder<FriendsBloc, FriendsState>(
            builder: (context, friendsState) {
              if (friendsState is FriendshipsStateLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (friendsState is FriendshipsStateError) {
                return Center(
                  child: Text('Error: ${friendsState.failure}'),
                );
              }

              final friends = friendsState.users ?? [];

              // Filter excluded friends
              final excludedIds = <int>[
                ...lobbyState.players.map((p) => p.userId),
                ...lobbyState.invites
                    .where((i) => i.status == InviteStatus.pending)
                    .map((i) => i.invitedUserId),
              ];

              final availableFriends = friends
                  .where((f) => !excludedIds.contains(f.userId))
                  .toList();

              if (availableFriends.isEmpty) {
                return Center(
                  child: Text(
                    friends.isEmpty
                        ? 'No friends yet.\nAdd friends to invite them!'
                        : 'All friends already invited!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                itemCount: availableFriends.length,
                itemBuilder: (context, index) {
                  final friend = availableFriends[index];
                  return InkWell(
                    onTap: () {
                      context.read<FriendBattleLobbyBloc>().add(
                            InviteFriendEvent(friend.userId),
                          );
                    },
                    child: CommonUserTile(
                      model: friend,
                      trailing:
                          const Icon(Icons.person_add, color: Colors.blue),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// Start Game Button
class _StartGameButton extends StatelessWidget {
  final FriendBattleLobbyState state;

  const _StartGameButton({required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed:
                  state.canStartGame && state.status != LobbyStatus.starting
                      ? () => context
                          .read<FriendBattleLobbyBloc>()
                          .add(const StartGameEvent())
                      : null,
              icon: const Icon(Icons.play_arrow),
              label: state.status == LobbyStatus.starting
                  ? const Text('Starting...')
                  : const Text('Start Game'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          if (!state.canStartGame)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                'Need at least 1 player to start',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}

// Invite Status Chip
class _InviteStatusChip extends StatelessWidget {
  final InviteStatus status;

  const _InviteStatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      InviteStatus.pending => ('Pending', Colors.orange),
      InviteStatus.accepted => ('Accepted', Colors.green),
      InviteStatus.rejected => ('Rejected', Colors.red),
      InviteStatus.expired => ('Expired', Colors.grey),
      InviteStatus.cancelled => ('Cancelled', Colors.grey),
    };

    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      backgroundColor: color.withOpacity(0.2),
      labelStyle: TextStyle(color: color),
    );
  }
}
