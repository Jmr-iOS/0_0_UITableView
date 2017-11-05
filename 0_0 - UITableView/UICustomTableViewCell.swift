//
//  UICustomTableViewCell.swift
//  0_0 - UITableView
//

import UIKit


class UICustomTableViewCell : UITableViewCell {
    
    @objc let verbose : Bool = false;
    
    @objc let cellSelectionFade : Bool = false;


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier:reuseIdentifier);

        if(self.cellSelectionFade == true) {
            self.selectionStyle = UITableViewCellSelectionStyle.gray;   //Options are 'Gray/Blue/Default/None'
        } else {
            self.selectionStyle = UITableViewCellSelectionStyle.none;
        }
        
        
        if(verbose){ print("CustomTableViewCell.init():    the CustomTableViewCell was initialized"); }
        
        return;
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

