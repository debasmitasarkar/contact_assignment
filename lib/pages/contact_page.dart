import 'package:contact_assignment/data/models/contact_response.dart';
import 'package:contact_assignment/data/remote_api.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  RemoteApi api = RemoteApi();
  PagingController<int, Contact> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  _fetchPage(int key) async {
    try {
      final newItems = await api.fetchContactList(key);
      final isLastPage = newItems.length < 20;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        _pagingController.appendPage(newItems, key + 1);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contacts Page'),
        ),
        body: PagedListView<int, Contact>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Contact>(
              itemBuilder: (context, item, index) => ListTile(
                    leading: Image.network(item.image),
                    title: Text('${item.firstName} ${item.lastName}'),
                  )),
        ));

    // FutureBuilder<List<Contact>>(
    //     future: api.fetchContactList(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         return ListView.builder(
    //           itemCount: snapshot.data!.length,
    //           itemBuilder: (context, index) {
    //             Contact contact = snapshot.data![index];
    //             return ListTile(
    //               leading: Image.network(contact.image),
    //               title: Text('${contact.firstName} ${contact.lastName}'),
    //             );
    //           },
    //         );
    //       } else if (snapshot.hasError) {
    //         return Text('error occured');
    //       } else {
    //         return Center(child: CircularProgressIndicator());
    //       }
    //     })
    //  );
  }
}
