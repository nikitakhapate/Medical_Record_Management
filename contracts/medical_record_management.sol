// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.21  ;
 pragma experimental ABIEncoderV2;
contract medical_record_management{

  event DoctorAddedSuccesfully(address owner, address doctor);
  event PatientAddedSuccesfully(address owner, address patient);
  event DoctorAddedPatientsPrescriptionDetails(string Doctor, string Patient);
  event patientGaveAccessToDoctor(string Patient , string Doctor);

  // To map address and strut
  mapping(uint256 => DocAddressName) public   Doctors;
  mapping(uint256 => PatAddressName)public   Patients;
  mapping(address=>doctor)   DoctorInfo;
  mapping(address=>patient)   PatientInfo;
  mapping(address=>mapping(address=>bool))   PatientToDoctor;

  uint public Doctor_count;
  uint public Patient_count;
  // structure for doctor
  struct   doctor  {
    string name;
    address id;
    bool flag; //to check if doctor is authorized
  }
  struct   PatAddressName  {
    string name;
    address id;   //to check if doctor is authorized
  }
  struct   DocAddressName  {
    string name;
    address id;   //to check if doctor is authorized
  }
  struct PrescriptionDetails {
    string doctor_name;
    string prescription;
  }

  struct patient{
    string name;
    address id;
    bool flag; //to check if patient is authorized
    string[] records;
  }


  address owner;

  constructor()  public {
    Doctor_count=0;Patient_count=0;
    owner=msg.sender;
  }

  modifier onlyOwner{
    require(owner==msg.sender);
    _;
  }
  modifier onlyDoctor{
    require(DoctorInfo[msg.sender].flag==true);
    _;
  }
  modifier onlypatient{
    require(PatientInfo[msg.sender].flag==true);
    _;
  }
  function addDoctor(address id, string memory name) public onlyOwner{
    Doctors[Doctor_count++]=DocAddressName(name, id);
    DoctorInfo[id]=doctor(name , id,true);
    emit DoctorAddedSuccesfully(msg.sender , id);
  }
  function addPatient(address id, string memory name,string[] memory record) public onlyDoctor{
    PatientToDoctor[id][id]=true;
    Patients[Patient_count++]=PatAddressName(name, id);
    PatientInfo[id]=patient(name , id,true, record);
    emit PatientAddedSuccesfully(msg.sender , id);
  }
  function accessToDoctor(address doc) public onlypatient{
    PatientToDoctor[msg.sender][doc]=true;
    emit   patientGaveAccessToDoctor(PatientInfo[msg.sender].name,DoctorInfo[doc].name);
  }

  function getDetailsOfPatient(address pa) public view returns(address Id,string memory Name,string[] memory Record){
  require(PatientToDoctor[pa][msg.sender]==true);
  Id=pa;
  Name=PatientInfo[pa].name;
  Record=PatientInfo[pa].records;

}
  function addPrescriptionOfPatient(address pat , string memory   prescription) public onlyDoctor{

    PatientInfo[pat].records.push( prescription);
    emit DoctorAddedPatientsPrescriptionDetails(DoctorInfo[msg.sender].name,PatientInfo[pat].name);
  }
}