import 'package:computers_crud/common-widgets/appbar/appbar.dart';
import 'package:computers_crud/entities/computer/computer.entity.dart';
import 'package:computers_crud/helpers/computers/computer.herlper.dart';
import 'package:flutter/material.dart';

class ComputerScreen extends StatefulWidget {
  const ComputerScreen({super.key});

  @override
  State<ComputerScreen> createState() => _ComputerScreenState();
}

class _ComputerScreenState extends State<ComputerScreen> {
  List<Computer> listComputers = [];
  bool isLoading = false;
  void loadComputers() async {
    isLoading = true;
    final computers = await ComputerHelper.getAllComputers();

    setState(() {
      listComputers = computers;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadComputers();
  }

  Future<void> insert() async {
    Computer computer = new Computer(
        model: modelController.text,
        processor: processorController.text,
        hardDisk: hardDiskController.text,
        ram: ramController.text);
    await ComputerHelper.insert(computer);
    loadComputers();
    processorController.text = "";
    hardDiskController.text = "";
    ramController.text = "";
  }

  Future<void> update(int id) async {
    Computer computer = new Computer(
        id: id,
        model: modelController.text,
        processor: processorController.text,
        hardDisk: hardDiskController.text,
        ram: ramController.text);
    await ComputerHelper.update(computer);
    loadComputers();
    processorController.text = "";
    hardDiskController.text = "";
    ramController.text = "";
  }

  Future<void> deleteComputer(int id) async {
    await ComputerHelper.delete(id);
    loadComputers();
  }

  final TextEditingController modelController = TextEditingController();
  final TextEditingController processorController = TextEditingController();
  final TextEditingController hardDiskController = TextEditingController();
  final TextEditingController ramController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: Appbar(title: 'Computadoras'),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            )
          : ListView.builder(
              itemCount: listComputers.length,
              itemBuilder: (context, index) => Card(
                    margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                    child: ListTile(
                      title: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          listComputers[index].model,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      subtitle: Text(
                        listComputers[index].processor +
                            " | " +
                            listComputers[index].hardDisk +
                            " | " +
                            listComputers[index].ram,
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                showBottomSheet(listComputers[index].id);
                              },
                              icon: Icon(Icons.edit, color: Colors.blue)),
                          IconButton(
                              onPressed: () async {
                                await deleteComputer(
                                    listComputers[index].id ?? 0);
                              },
                              icon: Icon(Icons.delete, color: Colors.red))
                        ],
                      ),
                    ),
                  )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => showBottomSheet(null),
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }

  void showBottomSheet(int? id) async {
    if (id != null) {
      Computer computer = listComputers.firstWhere((c) => c.id == id);
      modelController.text = computer.model;
      processorController.text = computer.processor;
      hardDiskController.text = computer.hardDisk;
      ramController.text = computer.ram;
    }

    showModalBottomSheet(
        elevation: 5,
        isScrollControlled: true,
        context: context,
        builder: (builder) => Container(
              padding: EdgeInsets.only(
                  top: 30,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: modelController,
                    maxLines: 1,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Modelo'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: processorController,
                    maxLines: 1,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Procesador'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: hardDiskController,
                    maxLines: 1,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Disco duro'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: ramController,
                    maxLines: 1,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'RAM'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8),),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .transparent, // Hacer que el fondo del botón sea transparente
                          shadowColor: Colors.transparent, // Sin sombra
                        ),
                        onPressed: () async {
                          if (id == null) {
                            await insert();
                          }
                          if (id != null) {
                            await update(id);
                          }
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(18),
                          child: Text(
                            id == null ? 'Agregar' : 'Actualizar',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600,color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}
