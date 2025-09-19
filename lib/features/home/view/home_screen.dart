import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguyen_ngoc_thang_nexlab/components/inputs/input_form_field.dart';
import 'package:nguyen_ngoc_thang_nexlab/features/home/bloc/home_bloc.dart';
import 'package:nguyen_ngoc_thang_nexlab/features/home/widgets/user_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(Init()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // Open sort modal bottom sheet
  Future<void> _onSortTap(BuildContext context, HomeBloc homeBloc) async {
    final selectedOrder = homeBloc.state.sortOrder;

    final result = await showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Sort',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                trailing: selectedOrder == HomeSortOrder.az
                    ? const Icon(Icons.check, color: Colors.blueAccent)
                    : null,
                title: Text(HomeSortOrder.az.displayName),
                onTap: () {
                  // Implement sorting logic here
                  Navigator.pop(ctx, HomeSortOrder.az);
                },
              ),
              ListTile(
                trailing: selectedOrder == HomeSortOrder.za
                    ? const Icon(Icons.check, color: Colors.blueAccent)
                    : null,
                title: Text(HomeSortOrder.za.displayName),
                onTap: () {
                  // Implement sorting logic here
                  Navigator.pop(ctx, HomeSortOrder.za);
                },
              ),
            ],
          ),
        );
      },
    );

    if (result == null) {
      return;
    }

    homeBloc.add(SortChanged(sortOrder: result));
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listenWhen: (previous, current) =>
            previous.status != current.status ||
            previous.deleteStatus != current.deleteStatus,
        listener: (context, state) {
          if (state.deleteStatus.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Failed to delete contact. Please try again.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.pinkAccent,
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: Container(
          alignment: Alignment.center,
          height: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            spacing: 16,
            children: [
              // Search box
              Row(
                spacing: 8,
                children: <Widget>[
                  Expanded(
                    child: BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        return InputFormField(
                          label: 'Search',
                          onChanged: (value) {
                            homeBloc.add(KeywordChanged(keyword: value));
                          },
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      homeBloc.add(SearchSubmitted());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.search_rounded,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              //Sort button
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () => _onSortTap(context, homeBloc),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(
                            Icons.sort,
                            size: 20,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Sort: ${state.sortOrder.displayName}',
                            style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return state.status.isLoading || state.status.isInitLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.blueAccent,
                          ),
                        )
                      : Expanded(
                          child: UserList(
                            users: state.users,
                            onRemove: (user) {
                              homeBloc.add(ContactDeleted(userId: user.id));
                            },
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
