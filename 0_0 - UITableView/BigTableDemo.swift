/************************************************************************************************************************************/
/** @file       BigTableDemo.swift
 *  @brief      create an 8x8 table demo
 *  @details    scrollable, with selectable & subviews
 *
 *  @section    Opens
 *      gen table
 *      cell text
 *      scrollable
 *      selectable
 *      subview
 *
 *
 *  @section    Legal Disclaimer
 *      All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *      Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import Foundation
import UIKit


class BigTableDemo : NSObject {


    /********************************************************************************************************************************/
    /** @fcn        int main(void)
     *  @brief      x
     *  @details    x

     */
    /********************************************************************************************************************************/
    override init() {
        super.init();
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        genBigTable(view : UIView)
     *  @brief      x
     *  @details    x
     
     */
    /********************************************************************************************************************************/
    class func genBigTable(view : UIView) {
        
        //Locals
        let verbose  : Bool = true;
        let numRows  : Int  = 10;
        
        var bigTable : BigTableView;
        var bigTableHandler : BigTableViewHandler;
        
        
        if(verbose){ print("BigTableDemo.genBigTable():      adding a big table"); }
        
        bigTable = BigTableView(frame:view.frame, style:UITableViewStyle.plain, numRows:numRows);
        
        //add the handler
        bigTableHandler = BigTableViewHandler(numRows:numRows, table: bigTable);
        
        bigTable.delegate   = bigTableHandler;                                          /* Set both to handle clicks & provide data */
        bigTable.dataSource = bigTableHandler;
        
        //init the table
        bigTable.separatorColor = UIColor.green;
        bigTable.separatorStyle = .singleLine;
        
        //Safety
        bigTable.backgroundColor = UIColor.gray;

        //Set the row height
        bigTable.rowHeight = 75;
        
        if(verbose){ print("BigTableDemo.genBigTable():      it was shown"); }
        
        view.addSubview(bigTable);
        
        bigTable.reloadData();
        
        return;
    }
    
    
}

