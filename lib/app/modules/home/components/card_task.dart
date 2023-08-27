import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytask/app/modules/home/components/modal_edittask.dart';
import 'package:mytask/app/providers/subtask_provider.dart';
import 'package:mytask/data/database.dart';
import 'package:provider/provider.dart';

class CardTask extends StatelessWidget {
  int _id;
  String _title;
  int _prioridade;
  Map<int, InlineSpan> prioridades = {
    0 : const TextSpan(text: "Baixa",style: TextStyle(fontWeight: FontWeight.normal,color: Colors.white)),
    1 : const TextSpan(text: "Média",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange)),
    2 : const TextSpan(text: "Alta",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red))
  };
  CardTask({Key? key,required String title, required int prioridade,required int id}) : _prioridade = prioridade, _title = title, _id = id, super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        OpenDatabase.getDatabase().then((value) => showDialog(context: context, builder: (context) => ModalEditTask(idTask: _id,db: value,)));
      },
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0,top: 8.0),
        child: Ink(
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                    color: Colors.black87,
                    border: Border.all(color: Colors.blueAccent,width: 3),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(0),topRight: Radius.circular(12),bottomRight: Radius.circular(12),bottomLeft: Radius.circular(32))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_title, style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.white,)),
                        const SizedBox(height: 10,),
                        RichText(text: TextSpan(text: "Prioridade: ",style: const TextStyle(fontWeight: FontWeight.bold),children: [prioridades[_prioridade]!]))
                      ],
                    ),
                    Consumer<SubTaskProvider>(
                      builder: (BuildContext context, SubTaskProvider subTask, Widget? child){
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Text("${(subTask.getPercentCompleted(_id) * 100).round()}%"),
                            SizedBox(
                              width: 55,
                              height: 55,
                              child: CircularProgressIndicator(
                                value: subTask.getPercentCompleted(_id),
                                strokeWidth: 5,
                              ),
                            )
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
