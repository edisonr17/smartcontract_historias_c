// SPDX-License-Identifier: MIT
pragma solidity >=0.6.6;

contract HistoriasContract {

	uint256 private counter = 0;
	uint256 private countEmp = 0;
	address private owner = 0x308925e628AA5011488cE4306b61571D695C08dD;

	//Struct para el formato base de historias clínicas registradas.
	struct History {
		uint256 id;
		address custo;
		string nombre;
		string desc;
		uint32 fec_cr;
		//definir array
		string _hashs;
		uint256 main;
	}

	//Formato base para el registro de empleados
	struct Employed
	{
		string name;
		string doc;
		string description;
		bool state;
		bool onlyReader;
	}

	//Definimos el tipo de dato que va a almacenar la historia
	mapping (uint256  => History) private his;
	mapping (address => Employed) private emp;

	//Declare an Event
	event Deposit(string);



//Emit an event

	//Value to save:
	//"Historia Clínica", 0xFc67a62E89577fE773ceC669C7e8D78c7Bd8a37c, "Evidencia de registro #1234567", "20211210", "QmUzsDZzfXrpqsXF19HRHDLCDneRcHoTNcoD27BJXZgXjz", 0
	 function savHis(string memory _nom, address _cus, string memory _desc, uint32 _fec,  string memory _hashs, uint256 _m) public {
		counter++;
		if(counter == 1){_m = 1;
		}


		if(owner == msg.sender || (_m > 0 && _cus == msg.sender) )
		{
			his[counter] = History(counter,_cus,_nom,_desc,_fec, _hashs, _m);
		}else{
			revert();
		}
	}


	//registramos el empleado que podrá tener acceso
	//Example  0x63AbAF2282d20f664287f468843182Cc60aa1549, "Edison Rave Molina", "1038768950", "Empleado de almacen hospital", true, false
	function registerEmployed(address _empHas, string memory _nom, string memory _doc, string memory _des, bool _state, bool _onlyReader) public {
		if(msg.sender != owner)
		{
			revert();
		}
	emp[_empHas] = Employed(_nom, _doc, _des, _state, _onlyReader);
	}



	//deshabilitar Empleado
   //example 0x63AbAF2282d20f664287f468843182Cc60aa1549
	function disabled(address _emp) public{
		if(msg.sender != owner ) {
			revert();
		}
		if(emp[_emp].state){
			emp[_emp].state = false;
		}
		else{
			emp[_emp].state = true;
		}
	}


	//Permite registrar una wallet encargada del documento.
	//example 1, 0x63AbAF2282d20f664287f468843182Cc60aa1549
	function setCustodi(uint256 _id, address _cust) public{
		if(msg.sender != owner || msg.sender == his[_id].custo ) {
			revert();
		}
		his[_id].custo = _cust;
	}




	//Metodo que permite obtener la historia por id
	//example 1
	function getH(uint256 _id) public view  returns (string memory _n, address _c, string memory _d, uint32 _f,  string memory _h, uint256 _m) {
		return (his[_id].nombre, his[_id].custo, his[_id].desc, his[_id].fec_cr, his[_id]._hashs, his[_id].main);
	}

}

