import 'package:flutter/material.dart';

class InvoiceScanningScreen extends StatelessWidget {
  const InvoiceScanningScreen({super.key});

  final bool noInvoiceAvl = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 247, 250),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 246, 247, 250),
        title: Text('Invoice Scanning'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (noInvoiceAvl) ...{
                Image.asset(
                  'assets/no_invoice_banner.png',
                  scale: 4.3,
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_to_photos_outlined,
                          color: Colors.white,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Scan Invoice',
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Color.fromARGB(255, 54, 158, 255),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15)),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
              },
              if (!noInvoiceAvl) ...{
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 110,
                      height: 160,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color.fromARGB(23, 26, 137, 255),
                            child: Icon(
                              Icons.add,
                              color: Color.fromARGB(255, 54, 158, 255),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Add\nInvoice',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 160,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                              gradient: RadialGradient(colors: [
                                Color.fromARGB(46, 54, 158, 255),
                                Color.fromARGB(37, 54, 158, 255),
                                Color.fromARGB(20, 54, 158, 255),
                              ]),
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '36',
                                style: TextStyle(
                                    fontSize: 40,
                                    color: Color.fromARGB(255, 54, 158, 255)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Saved\nInvoices",
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 160,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Saved Invoices",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "View all >>",
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
              }
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        backgroundColor: Color.fromARGB(255, 54, 158, 255),
        onPressed: () {},
        child: SizedBox(
          width: 130,
          child: Row(
            children: [
              Icon(
                Icons.add_to_photos_outlined,
                color: Colors.white,
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text("Scan")
            ],
          ),
        ),
      ),
    );
  }
}
