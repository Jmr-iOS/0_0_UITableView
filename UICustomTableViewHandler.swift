//
//  UICustomTableViewHandler.swift
//  0_0 - UITableView
//
//  @todo!!!
//  @note you need to create a custom handler to ensure the cell's are CREATED and ACCESSED differently in this example code
//        differently than the standard table example. It's not that a seperate class is REQUIRED, it's just dramatically cleaner and safer
//        for longterm retention!
//

import UIKit

class UICustomTableViewHandler : NSObject, UITableViewDataSource, UITableViewDelegate {
   
    @objc let verbose : Bool = true;
    
    @objc var timerTable : UICustomTableView!;
    
        
    @objc init(items: [String], timerTable : UICustomTableView) {

        self.timerTable = timerTable;
        
        if(verbose){ print("CustomTableViewHandler.init():    the CustomTableViewHandler was initialized"); }

        return;
    }

    
    /********************************************************************************************************************************/
    /*                                  UITableViewDataSource, UITableViewDelegate Interfaces                                        */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(verbose){ print("Handler.tableView():           (numberOfRowsInSection) The table will now have \(self.timerTable.getCellCount()), cause I just said so..."); }
        
        return self.timerTable.getCellCount();                                              //return how many rows you want printed....!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell : UICustomTableViewCell = self.timerTable.myCustomCells[(indexPath as NSIndexPath).item];
        
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if(true){ print("CustomTableViewHandler.tableView():         handling a cell tap of \((indexPath as NSIndexPath).item)"); }

        //CUSTOM
        timerTable.deselectRow(at: indexPath, animated:true);
        
        //eww... the traditional access method...
        //let currCell : UICustomTableViewCell = customTable.dequeueReusableCellWithIdentifier("cell") as! UICustomTableViewCell;
        
        let cell : UICustomTableViewCell = self.timerTable.getCell((indexPath as NSIndexPath).item);
        
        print("    We have cell '\( cell.textLabel?.text as String!)'");

        /****************************************************************************************************************************/
        /* scroll to the top or change the bar color                                                                                */
        /****************************************************************************************************************************/
        switch((indexPath as NSIndexPath).row) {
        case (0):
            print("top selected. Scrolling to the bottom!");
            timerTable.scrollToRow(at: IndexPath(row: self.timerTable.getCellCount()-1, section: 0), at: UITableViewScrollPosition.bottom, animated: true);
            break;
        case (1):
            self.timerTable.addNewCell("Woot Woot!");
            print("added a cell?");
            break;
        case (2):
            self.timerTable.setEditing(true, animated: true);
            print("editing is enabled");
            break;
        case (self.timerTable.getCellCount()-4):
            print("swapped the seperator color to blue");
            timerTable.separatorColor = UIColor.blue;
            break;
        case (self.timerTable.getCellCount()-3):
            print("scrolling to the top with a Rect and fade");
            timerTable.scrollRectToVisible(CGRect(x: 0,y: 0,width: 1,height: 1), animated:true);           //slow scroll to top
            break;
        case (self.timerTable.getCellCount()-2):
            print("scrolling to the top with a Rect and no fade");
            timerTable.scrollRectToVisible(CGRect(x: 0,y: 0,width: 1,height: 1), animated:false);          //immediate scroll to top
            break;
        case (self.timerTable.getCellCount()-1):
            print("scrolling to the top with scrollToRowAtIndexPath");
            timerTable.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true);
            break;
        default:
            print("I didn't program a reaction for this case. I was lazy...");
            break;
        }
        
        print("   ");
        
        return;
    }
    
    //src: http://stackoverflow.com/questions/24103069/swift-add-swipe-to-delete-tableviewcell
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        return true;
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if(self.timerTable.myCustomCells.count > 0) {
            self.timerTable.removeCell((indexPath as NSIndexPath).item);                 // handle delete (by removing the data from your array and updating the tableview)
        }
        
        return;
    }

    
/************************************************************************************************************************************/
/*                                                        Helpers                                                                   */
/************************************************************************************************************************************/
    @objc func getCharName(_ i : Int) -> String {
        return String(describing: UnicodeScalar(i + Int(("A" as UnicodeScalar).value)));
    }
    
    
    @objc func getRowLabel(_ charName : String, index: Int) -> String {
        return String(format: "Item '%@' (%d)", charName, index);
    }
    
    
    @objc func addNewRow() {
        
        let charName : String = self.getCharName(self.timerTable.getCellCount());
        
        let newLabel : String = self.getRowLabel(charName, index: self.timerTable.getCellCount());
  
        self.timerTable.addNewCell(newLabel);
        
        self.timerTable.reloadData();
        
        print("row was added '\(newLabel)'");
        
        return;
    }
    
}
