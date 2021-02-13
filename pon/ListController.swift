//
//  ListController.swift
//  pon
//
//  Created by Demir Dazdarevic on 4.2.21..
//

import Foundation
import UIKit


class ListController: UIViewController {
    
    
   
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tekst: UILabel!
    
    
    
    var zadaci=[String]()
    var odabrani=[String]()
    var obrisani=[String]()//vazi od paljenja do paljenja apk, koliko nam i treba
    
    //DICTIONARY KEY:VALUE
    var svi:[String:String]=[
        "Sedam ili više sati sna.":"1",
        "Doručkovali.":"2",
        "Ručali":"3",
        "Večerali.":"4",
        "Popili dva ili više litra vode.":"5",
        "Bili u toalet.":"6",
        "Sit libido.":"7",
        "Radni odnos/školovanje.": "11",
        "Finansijska pokrivenost.": "12",
        "Zadovoljavajuće zdravstveno stanje.": "13",
        "Krov nad glavom, dom.": "14",
        "Kontaktirati prijatelja.": "21",
        "Kontakt sa porodicom.": "22",
        "Partnerski odnos.": "23",
        "Osetiti samouverenost.": "31",
        "Doživljaj poštovanja od okoline.": "32",
        "Čin samoaktuelizacije.": "41"
    ]
    
    
    
    
   
    var freshLaunch = true
    
    override func viewWillAppear(_ animated: Bool) {
        
        zadaci.removeAll()
        changeTekst()
        addZadatke()
        ///ovako, UserDefaults cuva promene brisanja tek kad se aplikacija refreshuje..da bi se olaksalo, prvo proba da li moze da izbrise
        ///
        
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
         if freshLaunch == true {
             freshLaunch = false
            self.tabBarController!.selectedIndex = 1
            //self.tabBarController!.tabBar.shadowImage = nil
            
           
         }
    }
     
    override func viewDidLoad() {
        
        
       // self.tabBarController!.tabBar.shadowImage = nil
        super.viewDidLoad()
        
        
        
   
        }
    
    func changeTekst(){
        let preferences = UserDefaults.standard
        if(preferences.integer(forKey: "level")==0){
            tekst.text="Start your daily tasks  \n by clicking on plus button."
            
        }
        else if(preferences.integer(forKey: "level")==1){
            tekst.text="Current level of needs: \n physiology"
            
        }
        else if(preferences.integer(forKey: "level")==2){
            tekst.text="Current level of needs: \n security"
        }
        else if(preferences.integer(forKey: "level")==3){
            tekst.text="Current level of needs: \n belonging"
        }
        else if(preferences.integer(forKey: "level")==4){
            tekst.text="Current level of needs: \n esteem"
        }
        else if(preferences.integer(forKey: "level")==5){
            tekst.text="Current level of needs: \n self-actualization"
        }
        else if(preferences.integer(forKey: "level")==6){
            tekst.text="Congratulations.\n You had a day of fully met needs.\n That's awesome! Here's something :"
        }
        
        
    }
    
    func addUradjene() {
        let preferences = UserDefaults.standard
        //makni odabrane
        for i in odabrani{
            preferences.removeObject(forKey: i)
            //zadaci.removeAll(where: T##(String) throws -> Bool)
            let intVal = Int(i) ?? 0
            if(intVal < 10){
                var poeni = preferences.integer(forKey: "poeni1")
                poeni += 1
                preferences.setValue(poeni, forKey: "poeni1")
            }
            else if(intVal >= 10 && intVal<20){
                var poeni = preferences.integer(forKey: "poeni2")
                poeni += 1
                preferences.setValue(poeni, forKey: "poeni2")
            }
            else if(intVal >= 20 && intVal<30){
                var poeni = preferences.integer(forKey: "poeni3")
                poeni += 1
                preferences.setValue(poeni, forKey: "poeni3")
            }
            else if(intVal >= 30 && intVal<40){
                var poeni = preferences.integer(forKey: "poeni4")
                poeni += 1
                preferences.setValue(poeni, forKey: "poeni4")
            }
            else if(intVal >= 40 && intVal<50){
                var poeni = preferences.integer(forKey: "poeni5")
                poeni += 1
                preferences.setValue(poeni, forKey: "poeni5")
            }
        }
        
        setLevel(poeni1: preferences.integer(forKey: "poeni1"), poeni2: preferences.integer(forKey: "poeni2"), poeni3: preferences.integer(forKey: "poeni3"), poeni4: preferences.integer(forKey: "poeni4"), poeni5: preferences.integer(forKey: "poeni5"))
        
        odabrani.removeAll() //cini mi se da treba da ocistim za kraj
    }
    
    func setLevel(poeni1:Int,poeni2:Int,poeni3:Int,poeni4:Int,poeni5:Int){
        print("Poeni- p1: \(poeni1) ,p2: \(poeni2) ,p3: \(poeni3) ,p4: \(poeni4) ,p5: \(poeni5) ")
        let preferences = UserDefaults.standard
            let ukupno = poeni1+poeni2+poeni3+poeni4+poeni5
            if(ukupno == 17 ) {
                preferences.setValue(6, forKey: "level")
            }
            else if(poeni1>=3 && poeni2>=2 && poeni3>=2 && poeni4>=1) {
                preferences.setValue(5, forKey: "level")
            }
            else if(poeni1>=3 && poeni2>=2 && poeni3>=2) {
                preferences.setValue(4, forKey: "level")
            }
            else if(poeni1>=3 && poeni2>=2 ) {
                preferences.setValue(3, forKey: "level")
            }
            else if(poeni1>=3 ) {
                preferences.setValue(2, forKey: "level")
            }
            else if(poeni1<3 ) {
                preferences.setValue(1, forKey: "level")
            }
            else {
                print("Greska kod setLevel")
                return
                
            }
            
        }
        //post NA SERVER
        
        //dodaj poene
        
        
        //ovde ide iz array na server , i brisi iz preferences
        //na plus nek se pozove ova f-ja
   
    
    func addZadatke() {
        
        let preferences = UserDefaults.standard
        if preferences.integer(forKey: "level") == 0 {
            ///Lazni kod
            
            preferences.setValue(1, forKey: "level")
                //zadaciid.append(keyN)
            }
        
        else if preferences.integer(forKey: "level") == 1 {
            print("na kec sam")
            for i in 1...10 {
                
                var keyN = String(i)
                guard let temp = preferences.string(forKey: keyN) else
                      {
                    //print("nema ovog")
                    continue }
                zadaci.append(temp)
                print(zadaci.last)
               // zadaciid.append(keyN)
            }
        }
        else if preferences.integer(forKey: "level") == 2 {
            for i in 1...20 {
                
                var keyN = String(i)
                guard let temp = preferences.string(forKey: keyN) else
                      {
                   // print("nema ovog")
                    continue }
                zadaci.append(temp)
               // zadaciid.append(keyN)
            }
        }
        else if preferences.integer(forKey: "level") == 3 {
            for i in 1...30 {
                
                var keyN = String(i)
                guard let temp = preferences.string(forKey: keyN) else
                      {
                    //print("nema ovog")
                    continue }
                zadaci.append(temp)
               // zadaciid.append(keyN)
            }
        }
        else if preferences.integer(forKey: "level") == 4 {
            for i in 1...40 {
                
                var keyN = String(i)
                guard let temp = preferences.string(forKey: keyN) else
                      {
                    //print("nema ovog")
                    continue }
                zadaci.append(temp)
               // zadaciid.append(keyN)
            }
        }
        else if preferences.integer(forKey: "level") == 5 {
            for i in 1...45 {
                
                var keyN = String(i)
                guard let temp = preferences.string(forKey: keyN) else
                      {
                    //print("nema ovog")
                    continue }
                zadaci.append(temp)
               // zadaciid.append(keyN)
            }
        }
        else if preferences.integer(forKey: "level") == 6 {
            //Label i svaka cast za kraj dana
            
        }
        
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        //let preferences = UserDefaults.standard
        
        addUradjene()
        
        //zadaci.removeAll()
        
        self.tabBarController!.selectedIndex = 1
        
        
    }
    /*var items:[String]=["prvi","drugi","treci"]
       
         
        for item in items{
            var novi = UITableViewCell()
            var label = UILabel()
            let dugme = Checkbox(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
           
           // novi.addSubview(dugme)
            //novi.alignmentRectInsets.left = 20
            
            
            
            label.backgroundColor = UIColor.yellow
            
            label.textAlignment = .center
            label.text = item
            novi.addSubview(label)
            novi.addSubview(dugme)
            //label.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            //label.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
            tabl.addSubview(novi)
            
          
            //novi.centerYAnchor.constraint(equalTo: listaZadataka.centerYAnchor).isActive = true
            //novi.centerXAnchor.constraint(equalTo: listaZadataka.centerXAnchor).isActive = true
           
           // novi.addArrangedSubview(dugme)
            
            
            /*
            label.centerYAnchor.constraint(equalTo: novi.centerYAnchor).isActive = true
            label.centerXAnchor.constraint(equalTo: novi.centerXAnchor).isActive = true
            */
            
            //novi.addSubview(label)
            //novi.addSubview(dugme)
            
            */
            
  
        
        
        
      
      
        /*for item in items {
            var novi = Zadatak.init(frame: self.accessibilityFrame)
            novi.zad.text=item
            self.skrol.addSubview(novi) */
         /* item2.imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: -20, right: 0);n*/
          
        
        
        
        
        
        
    }

extension ListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me")
    }
}

extension ListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("broj Zadataka: \(zadaci.count)")
        return zadaci.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.textColor = .secondaryLabel
        
        cell.textLabel?.text = zadaci[indexPath.row]
        cell.layoutMargins.left = 40
        
        let dugme = Checkbox(frame: CGRect(x: 330, y: 10, width: 25, height: 25))
        
        
        dugme.borderStyle = .circle
        dugme.uncheckedBorderColor = .gray
        dugme.checkedBorderColor = .red
        dugme.checkmarkStyle = .tick
        dugme.checkmarkColor = .red
        dugme.isChecked = false
        //dugme.
        dugme.valueChanged = { [self] (isChecked) in
            if isChecked == true {odabrani.append("\(svi[self.zadaci[indexPath.row]] ?? "nesto")")
            //print("I am checked \(isChecked). Also, my name is \(self.zadaci[indexPath.row])")
                print(odabrani.joined(separator: ","));}
            else {//odabrani.remove(at: Int(svi[self.zadaci[indexPath.row]])) Else Radi
                //odabrani sadrzi id-ove
                odabrani.removeAll{ $0 == "\(svi[self.zadaci[indexPath.row]] ?? "nesto")"};
               // print("I am : \(isChecked). Also, my name is \(svi[self.zadaci[indexPath.row]] ??  "neko")")
                print(odabrani.joined(separator: ","));
            }
       
            ///THIS IS WORKING SO GO FROM HERE UP ! bravo
        }
            
            
        dugme.checkboxFillColor = .tertiarySystemGroupedBackground
        cell.addSubview(dugme)
        return cell
    }
    
    
}
 /*
{ if(isChecked) {
    
    guard let temp = svi[zadaci[indexPath.row]]) else {
        return }
    odabrani.append(temp)
}
else {
    
}
*/



