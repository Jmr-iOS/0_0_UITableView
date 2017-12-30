/************************************************************************************************************************************/
/** @file		UICustomTableViewHandler.swift
 *  @project    x
 * 	@brief		x
 * 	@details	x
 *
 * 	@author		Justin Reina, Firmware Engineer, Jaostech
 *  @created    11/5/17
 *  @last rev   11/26/17
 *
 * 	@note you need to create a custom handler to ensure the cell's are CREATED and ACCESSED differently in this example code
 *        differently than the standard table example. It's not that a seperate class is REQUIRED, it's just dramatically cleaner and
 *        safer for longterm retention!
 *
 * 	@section	Opens
 * 			full review & completion
 *
 * 	@section	Legal Disclaimer
 * 			All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 * 			Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class BigTableViewHandler : NSObject, UITableViewDataSource, UITableViewDelegate {
   
    let verbose : Bool = true;
    
    var table : BigTableView!;
    
    var numRows : Int;
    
    /********************************************************************************************************************************/
    /** @fcn        init(numRows: Int, table : BigTableView)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    init(numRows: Int, table : BigTableView) {

        self.table = table;
        
        self.numRows = numRows;
        
        if(verbose){ print("BigTableViewHandler.init():    the BigTableViewHandler was initialized"); }

        return;
    }

    
/************************************************************************************************************************************/
/*                                  UITableViewDataSource, UITableViewDelegate Interfaces                                        	*/
/************************************************************************************************************************************/


    /********************************************************************************************************************************/
	/**	@fcn		tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(verbose){ print("Handler.tableView():           (numberOfRowsInSection) The table will now have \(self.table.getCellCount()), cause I just said so..."); }
        
        return self.table.getCellCount();                                  /* return how many rows you want printed....!            */
    }
    
    
    /********************************************************************************************************************************/
	/**	@fcn		tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell : BigTableViewCell = self.table.myBigCells[(indexPath as NSIndexPath).item];
        
        return cell;
    }
    
    
    /********************************************************************************************************************************/
	/**	@fcn		tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if(true){ print("CustomTableViewHandler.tableView():         handling a cell tap of \((indexPath as NSIndexPath).item)"); }

        //CUSTOM
        table.deselectRow(at: indexPath, animated:true);
        
        //eww... the traditional access method...
        //let currCell : UICustomTableViewCell = customTable.dequeueReusableCellWithIdentifier("cell") as! UICustomTableViewCell;
        
        let cell : BigTableViewCell = self.table.getCell((indexPath as NSIndexPath).item);
        
        print("    We have cell '\( cell.textLabel?.text as String!)'");

        /****************************************************************************************************************************/
        /* scroll to the top or change the bar color                                                                                */
        /****************************************************************************************************************************/
        switch((indexPath as NSIndexPath).row) {
        case (0):
            print("top selected. Scrolling to the bottom!");
            table.scrollToRow(at: IndexPath(row: self.table.getCellCount()-1, section: 0), at: UITableViewScrollPosition.bottom, animated: true);
            break;
        case (1):
            self.table.addNewCell("Woot Woot!");
            print("added a cell?");
            break;
        case (2):
            self.table.setEditing(true, animated: true);
            print("editing is enabled");
            break;
        case (self.table.getCellCount()-4):
            print("swapped the seperator color to blue");
            table.separatorColor = UIColor.blue;
            break;
        case (self.table.getCellCount()-3):
            print("scrolling to the top with a Rect and fade");
            table.scrollRectToVisible(CGRect(x: 0,y: 0,width: 1,height: 1), animated:true);           //slow scroll to top
            break;
        case (self.table.getCellCount()-2):
            print("scrolling to the top with a Rect and no fade");
            table.scrollRectToVisible(CGRect(x: 0,y: 0,width: 1,height: 1), animated:false);          //immediate scroll to top
            break;
        case (self.table.getCellCount()-1):
            print("scrolling to the top with scrollToRowAtIndexPath");
            table.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true);
            break;
        default:
            print("I didn't program a reaction for this case. I was lazy...");
            break;
        }
        
        print("   ");
        
        return;
    }
    
    
    /********************************************************************************************************************************/
	/**	@fcn		tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
	 *  @brief		x
	 *  @details	x
	 *
	 *  @section	Source
	 *		http://stackoverflow.com/questions/24103069/swift-add-swipe-to-delete-tableviewcell
	 */
	/********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        return true;
    }
    
    
    /********************************************************************************************************************************/
	/**	@fcn		tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if(self.table.myBigCells.count > 0) {
            self.table.removeCell((indexPath as NSIndexPath).item);            /* handle delete (by removing the data from     */
        }                                                                           /* your array and updating the tableview)       */
        
        return;
    }

    
/************************************************************************************************************************************/
/*                                                        Helpers                                                                   */
/************************************************************************************************************************************/
    
    /********************************************************************************************************************************/
	/**	@fcn		getCharName(_ i : Int) -> String
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
    func getCharName(_ i : Int) -> String {
        return String(describing: UnicodeScalar(i + Int(("A" as UnicodeScalar).value)));
    }
    
    
    /********************************************************************************************************************************/
	/**	@fcn		getRowLabel(_ charName : String, index: Int) -> String
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
    func getRowLabel(_ charName : String, index: Int) -> String {
        return String(format: "Item '%@' (%d)", charName, index);
    }
    
    
    /********************************************************************************************************************************/
	/**	@fcn		addNewRow()
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
    func addNewRow() {
        
        let charName : String = self.getCharName(self.table.getCellCount());
        
        let newLabel : String = self.getRowLabel(charName, index: self.table.getCellCount());
  
        self.table.addNewCell(newLabel);
        
        self.table.reloadData();
        
        print("row was added '\(newLabel)'");
        
        return;
    }
    
}
