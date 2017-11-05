//
//  UICustomTableView.swift
//  0_0 - UITableView
//
//  URL: (awesome) http://code.tutsplus.com/tutorials/ios-sdk-crafting-custom-uitableview-cells--mobile-15702
//

import UIKit


class UICustomTableView : UITableView {
    
    var verbose : Bool = true;

    var myCustomCells : [UICustomTableViewCell] = [UICustomTableViewCell]();

    
    init(frame: CGRect, style: UITableViewStyle, items :[String]) {
        super.init(frame:frame, style:style);
        
        self.register(UICustomTableViewCell.self, forCellReuseIdentifier: "cell");          //I have no idea why we do this
        
        self.translatesAutoresizingMaskIntoConstraints = false;                            //Std
        
        for i in 0...items.count {
            
            let newCell : UICustomTableViewCell = UICustomTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "why");
            
            let cellText:String = "P\(i)";
            
            let subjectField:UILabel = UILabel(frame: CGRect(x:55, y: 25, width: 303, height:  25));
            
            subjectField.text = cellText;
            
            newCell.addSubview(subjectField);
            
            myCustomCells.append(newCell);
        }
        
        
        if(verbose){ print("CustomTableView.init():    the CustomTableView was initialized"); }

        return;
    }
    
    
    func addNewCell(_ cellString : String) {
    
        
        let newCell : UICustomTableViewCell = UICustomTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "eww?");
        
        myCustomCells.append(newCell);
        
        self.reloadData();
        
        if(verbose){ print("CustomTableView.addCell():    a new cell was added"); }

        return;
    }
    
    //self.timerTable.removeCell(indexPath.item);
    func removeCell(_ index : Int) {
        
        myCustomCells.remove(at: index);
        
        self.reloadData();
        
        self.sizeToFit();
        
        //turn mode off (just cause, for demo's sake
        self.setEditing(false, animated: true);

        print("cell removed");
        
        return;
    }
    
    
    func getCell(_ index: Int) -> UICustomTableViewCell {
    
        let cell : UICustomTableViewCell = self.myCustomCells[index];

        return cell;
    }
    
    func getCellCount() -> Int {
        return myCustomCells.count;
    }


    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

