/************************************************************************************************************************************/
/** @file		BigTableView.swift
 *  @project    x
 * 	@brief		x
 * 	@details	x
 *
 * 	@author		Justin Reina, Firmware Engineer, Jaostech
 *  @created    11/5/17
 *  @last rev   11/26/17
 *
 *
 * 	@notes		x
 *
 * 	@section	Opens
 * 			none current
 *
 *  @section    Reference
 *      (awesome) http://code.tutsplus.com/tutorials/ios-sdk-crafting-custom-uitableview-cells--mobile-15702
 *
 * 	@section	Legal Disclaimer
 * 			All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 * 			Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class BigTableView : UITableView {
    
    @objc var verbose : Bool = true;

    @objc var myBigCells : [BigTableViewCell] = [BigTableViewCell]();

    
    /********************************************************************************************************************************/
	/**	@fcn		init(frame: CGRect, style: UITableViewStyle, items :[String])
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
    init(frame: CGRect, style: UITableViewStyle, numRows : Int) {
        super.init(frame:frame, style:style);
        
        self.register(BigTableViewCell.self, forCellReuseIdentifier: "cell");
        
        self.translatesAutoresizingMaskIntoConstraints = false;                            //Std
        
        for i in 0...(numRows-1) {
            
            let newCell : BigTableViewCell = BigTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "why");
            
            let cellText:String = "B\(i)";
            
            let subjectField:UILabel = UILabel(frame: CGRect(x:55, y: 25, width: 303, height:  25));
            
            subjectField.text = cellText;
            
            newCell.addSubview(subjectField);
            
            myBigCells.append(newCell);
        }
        
        
        if(verbose){ print("BigTableView():    the BigTableView was initialized"); }

        return;
    }
    
    
    /********************************************************************************************************************************/
	/**	@fcn		addNewCell(_ cellString : String)
	 *  @brief		x
	 *  @details	x
	 *
	 *  @section	Purpose
	 *  	x
	 *
	 *  @param		[in]	name	descrip
	 *
	 *  @param		[out]	name	descrip
	 *
	 *  @return		(type) descrip
	 *
	 *  @pre		x
	 *
	 *  @post		x
	 *
	 *  @section	Operation
	 *		x
	 *		
	 *  @section	Opens
	 *  	x
	 *
	 *  @section	Hazards & Risks
	 *  	x
	 *
	 *	@section	Todo
	 *		x
	 *
	 *  @section	Timing
	 *  	x
	 *
	 *  @note		x
	 */
	/********************************************************************************************************************************/
    func addNewCell(_ cellString : String) {
    
        
        let newCell : BigTableViewCell = BigTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "eww?");
        
        myBigCells.append(newCell);
        
        self.reloadData();
        
        if(verbose){ print("BigTableView.addCell():    a new cell was added"); }

        return;
    }
    
    
    /********************************************************************************************************************************/
	/**	@fcn		removeCell(_ index : Int)
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
    func removeCell(_ index : Int) {
        
        myBigCells.remove(at: index);
        
        self.reloadData();
        
        self.sizeToFit();
        
        //turn mode off (just cause, for demo's sake
        self.setEditing(false, animated: true);

        print("cell removed");
        
        return;
    }
    
    
    /********************************************************************************************************************************/
	/**	@fcn		getCell(_ index: Int) -> UICustomTableViewCell
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
    func getCell(_ index: Int) -> BigTableViewCell {
    
        let cell : BigTableViewCell = self.myBigCells[index];

        return cell;
    }
    
    
    /********************************************************************************************************************************/
	/**	@fcn		getCellCount() -> Int
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
    func getCellCount() -> Int {
        return myBigCells.count;
    }


    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

