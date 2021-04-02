//
//  ViewController.swift
//  shareDemo
//
//  Created by Adsum MAC 1 on 01/04/21.
//

import UIKit
import PDFGenerator
class ViewController: UIViewController {
    
    let tbl = UITableView()
    @IBOutlet weak var nav: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tbl.frame = CGRect(x: 0, y: nav.frame.height, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(self.tbl)
        tbl.delegate = self
        tbl.dataSource = self
        tbl.register(UINib(nibName: "TableCell", bundle: nil), forCellReuseIdentifier: "TableCell")
    }
    @IBAction func share(_ sender: Any) {
        do {
            var dst =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
            dst = dst?.appendingPathComponent("UnpaidFeeSummary.pdf")
            try PDFGenerator.generate(tbl, to:dst! )
            loadPDFAndShare(path: dst!)
            self.viewDidLoad()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    //
    //    func pdfDataWithTableView(tableView: UITableView) -> NSMutableData {
    //
    //
    //            let priorBounds = tableView.bounds
    //        let fittedSize = tableView.sizeThatFits(CGSize(width: priorBounds.size.width, height: tableView.frame.height))
    //        tableView.bounds = CGRect(x: 0, y: 0, width: fittedSize.width, height: fittedSize.height)
    //        let pdfPageBounds = CGRect(x: 0, y: 0, width: tableView.frame.width, height: self.view.frame.height)
    //            let pdfData = NSMutableData()
    //            UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds,nil)
    //            var pageOriginY: CGFloat = 0
    //            while pageOriginY < fittedSize.height {
    //                UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
    //                UIGraphicsGetCurrentContext()!.saveGState()
    //                UIGraphicsGetCurrentContext()!.translateBy(x: 0, y: -pageOriginY)
    //                tableView.layer.render(in: UIGraphicsGetCurrentContext()!)
    //                UIGraphicsGetCurrentContext()!.restoreGState()
    //                pageOriginY += pdfPageBounds.size.height
    //            }
    //            UIGraphicsEndPDFContext()
    //            tableView.bounds = priorBounds
    //
    //        var docURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as NSURL
    //        docURL = docURL.appendingPathComponent( "myDocument.pdf")! as NSURL
    //        pdfData.write(to: docURL as URL, atomically: true)
    //        return pdfData
    //        }
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 20{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableCell
            cell.lbl.isHidden = true
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableCell
            cell.lbl.text = "\(indexPath.row+1)"
            return cell
        }
        
    }
    
    
}
extension UIViewController{
    func loadPDFAndShare(path:URL){
        
        let documento = NSData(contentsOf: path)
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [documento!], applicationActivities: nil)
        activityViewController.excludedActivityTypes = []
        activityViewController.popoverPresentationController?.sourceView=self.view
        present(activityViewController, animated: true, completion: nil)
        
        if activityViewController.isBeingDismissed{
            print("Dismiss")
        }else{
            print("NotDismiss")
        }
    }
    
}
extension UIActivityViewController{
    
}
