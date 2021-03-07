part of kandy;

class CloudFirestoreSearch extends StatefulWidget {
  @override
  _CloudFirestoreSearchState createState() => _CloudFirestoreSearchState();
}

class _CloudFirestoreSearchState extends State<CloudFirestoreSearch> {
  String n = "";

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection('bangla_movies');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Card(
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                n = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // ignore: unnecessary_null_comparison
        stream: (n != "")
            ? query.where("s", arrayContains: n).snapshots()
            : query.snapshots(),

        builder: (context, stream) {
          QuerySnapshot? querySnapshot = stream.data;
          if (stream.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitCircle(
                color: Color(0xffFF0000),
                size: 50.0,
              ),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: querySnapshot!.size,
            itemBuilder: (context, index) {
              DocumentSnapshot data = querySnapshot.docs[index];
              return Card(
                child: Row(
                  children: <Widget>[
                    Image.network(
                      data['a'],
                      width: 250,
                      height: 400,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      data['n'],
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SomeList {
  QuerySnapshot firstList;
  QuerySnapshot secondList;
  QuerySnapshot thirdList;
  QuerySnapshot fourthList;

  SomeList(this.firstList, this.secondList, this.thirdList, this.fourthList);
}
