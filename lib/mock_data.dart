import 'package:partner/models/destination_model.dart';
import 'package:partner/models/person_model.dart';
import 'package:partner/models/task_model.dart';



List<Task> taskList = [
  Task(
    id: "1",
    title: "Đại học Y Dược2",
    description: "Gom đủ khối lượng...",
    datetime: DateTime(2025, 3, 27, 16, 30),
    route: "Quận 5 (TP.HCM) => Quận 10 (TP.HCM)",
    cargoType: "Rác thải y tế1",
    price: 1200000,
  ),
  Task(
    id: "2",
    title: "Chợ Rẫy2",
    description: "Gom đủ khối lượng...",
    datetime: DateTime(2025, 3, 27, 14, 20),
    route: "Quận 5 (TP.HCM) => Quận 10 (TP.HCM)",
    cargoType: "Rác thải y tế2",
    price: 500000,
  ),
  Task(
    id: "3",
    title: "Bệnh viện FV3",
    description: "Gom đủ khối lượng...",
    datetime: DateTime(2025, 3, 27, 17, 30),
    route: "Quận 5 (TP.HCM) => Quận 10 (TP.HCM)",
    cargoType: "Rác thải y tế3",
    price: 800000,
  ),
  Task(
    id: "4",
    title: "Bệnh viện FV",
    description: "Gom đủ khối lượng...",
    datetime: DateTime(2025, 3, 26, 17, 30),
    route: "Quận 5 (TP.HCM) => Quận 10 (TP.HCM)",
    cargoType: "Rác thải y tế4",
    price: 800000,
  ),
  Task(
    id: "5",
    title: "Bệnh viện FV",
    description: "Gom đủ khối lượng...",
    datetime: DateTime(2025, 3, 13, 17, 30),
    route: "Quận 5 (TP.HCM) => Quận 10 (TP.HCM)",
    cargoType: "Rác thải y tế",
    price: 800000,
  ),
];

List<DestinationModel> mockDestinations = [
  DestinationModel(
    companyName: "Công Ty CP SX TM Sáng Việt",
    bd: 0,
    cc: 588,
    gom: "L1/1",
    note: "Gom đủ khối lượng không phát sinh",
    contactName: "Chị Giao",
    contactPhone: "0123456789",
    address: "123 Đường ABC, Quận 1, TP.HCM",
    latitude: 16.4667,
    longitude: 107.5944,
  ),
  DestinationModel(
    companyName: "Công Ty TNHH ABC",
    bd: 5,
    cc: 250,
    gom: "L1/2",
    note: "Có phát sinh khối lượng, cần kiểm tra lại",
    contactName: "Anh Huy",
    contactPhone: "0987654321",
    address: "456 Đường XYZ, Quận 1, TP.HCM",
    latitude: 16.4638,
    longitude: 107.5899,
  ),
];

List<PersonModel> personList = [
  PersonModel(name: "Nguyen Tan Duy", licensePlate: "75C-456022", msx: "C123"),
];
