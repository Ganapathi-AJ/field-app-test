import 'package:flutter/material.dart';

class InvoiceScanningScreen extends StatelessWidget {
  const InvoiceScanningScreen({super.key});

  final bool noInvoiceAvl = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 247, 250),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 246, 247, 250),
        title: const Text('Invoice Scanning'),
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
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color.fromARGB(255, 54, 158, 255),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
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
                  ),
                ),
                const SizedBox(
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
                      child: const Column(
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
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                              gradient: const RadialGradient(colors: [
                                Color.fromARGB(46, 54, 158, 255),
                                Color.fromARGB(37, 54, 158, 255),
                                Color.fromARGB(20, 54, 158, 255),
                              ]),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Column(
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
                const SizedBox(
                  height: 25,
                ),
                const Row(
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
                const SizedBox(
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
        backgroundColor: const Color.fromARGB(255, 54, 158, 255),
        onPressed: () {},
        child: const SizedBox(
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
