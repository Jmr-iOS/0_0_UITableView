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
   
    let verbose : Bool = true;
    
    var itemCount : Int!;
    
    var customTable : UICustomTableView!;
    
    var myCustomCells : [UICustomTableViewCell] = [UICustomTableViewCell]();
    
//!!!    var items : [String]!;
    
    init(items: [String], customTable : UICustomTableView) {
        
//!!!        self.items = items;
        
        self.customTable = customTable;
        
        if(verbose){ print("CustomTableViewHandler.init():    the CustomTableViewHandler was initialized"); }

        return;
    }
    
    
    func getCell(index: Int) -> UICustomTableViewCell {
        
        let cell : UICustomTableViewCell = myCustomCells[index];
        
        return cell;
    }
    
    
    /********************************************************************************************************************************/
    /*                                  UITableViewDataSource, UITableViewDelegate Interfaces                                        */
    /********************************************************************************************************************************/
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(verbose){ print("sCustomTableViewHandler.tableView():         The table will now have \(myCustomCells.count), cause I just said so..."); }
        
        return myCustomCells.count;                                                         //return how many rows you want printed....!
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if(verbose){ print("sCustomTableViewHandler.tableView():         adding a cell"); }

        let cell : UICustomTableViewCell!;
        
        cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UICustomTableViewCell!;
        
//        let newTextValue:String = self.items[indexPath.row];
        
        //(available)
        //cell.textLabel?.text = newTextValue;                                                //text
        //cell.textLabel?.font = UIFont(name: cell.textLabel!.font.fontName, size: 20);       //font
        //cell.textLabel?.textAlignment = NSTextAlignment.Center;                             //alignment
        
        let cellText:String = "Q\(indexPath.item)";
        
        let subjectField:UILabel = UILabel(frame: CGRect(x:55, y: 25, width: 303, height:  25));
        
        subjectField.text = cellText;
        
        //cell.textLabel?.text = cellText;      //other option
        cell.addSubview(subjectField);

        if(verbose){ print("'???' was added to the table"); }
        
        //add it to the table
        myCustomCells.append(cell);
        
        return cell;
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        if(true){ print("CustomTableViewHandler.tableView():         handling a cell tap of \(indexPath.item)"); }

        //CUSTOM
        customTable.deselectRowAtIndexPath(indexPath, animated:true);
        
        //eww... the traditional access method...
        //let currCell : UICustomTableViewCell = customTable.dequeueReusableCellWithIdentifier("cell") as! UICustomTableViewCell;
        
        let cell : UICustomTableViewCell = self.getCell(indexPath.item);
        
        print("    We have cell '\( cell.textLabel?.text as String!)'");

        /****************************************************************************************************************************/
        /* scroll to the top or change the bar color                                                                                */
        /****************************************************************************************************************************/
        switch(indexPath.row) {
        case (0):
            print("top selected. Scrolling to the bottom!");
            customTable.scrollToRowAtIndexPath(NSIndexPath(forRow: items.count-1, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true);
            break;
        case (1):
            print("added a cell?");
            break;
        case (items.count-4):
            print("swapped the seperator color to blue");
            customTable.separatorColor = UIColor.blueColor();
            break;
        case (items.count-3):
            print("scrolling to the top with a Rect and fade");
            customTable.scrollRectToVisible(CGRectMake(0,0,1,1), animated:true);           //slow scroll to top
            break;
        case (items.count-2):
            print("scrolling to the top with a Rect and no fade");
            customTable.scrollRectToVisible(CGRectMake(0,0,1,1), animated:false);          //immediate scroll to top
            break;
        case (items.count-1):
            print("scrolling to the top with scrollToRowAtIndexPath");
            customTable.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true);
            break;
        default:
            print("I didn't program a reaction for this case. I was lazy...");
            break;
        }
        
        print("   ");
        
        return;
    }
    
    
    
    func getCharName(i : Int) -> String {
        return String(UnicodeScalar(i + Int(("A" as UnicodeScalar).value)));
    }
    
    
    func getRowLabel(charName : String, index: Int) -> String {
        return String(format: "Item '%@' (%d)", charName, index);
    }
    
    
    func addNewRow() {
        
        let charName : String = self.getCharName(items.count);
        
        items.append(self.getRowLabel(charName, index: items.count));
        
        self.customTable.reloadData();
        
        print("row was added '\(items[items.count-1])'");
        
        return;
    }
    
}
