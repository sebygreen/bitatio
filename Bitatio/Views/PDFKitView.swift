//
//  PDFView.swift
//  Bitatio
//
//  Created by Sebastien Green on 29/06/2023.
//

import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {
    let url: URL // new variable to get the URL of the document
    
    func makeUIView(context: UIViewRepresentableContext<PDFKitView>) -> PDFView {
        // Creating a new PDFVIew and adding a document to it
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: self.url)
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: UIViewRepresentableContext<PDFKitView>) {
        // we will leave this empty as we don't need to update the PDF
    }
}

struct PDFView_Previews: PreviewProvider {
    static var previews: some View {
        PDFKitView(url: URL(string: "https://www.annemasse-agglo.fr/sites/default/files/2022-02/MAQ_20220202_GUIDE-COMPOSTAGE_BD_2.pdf")!)
    }
}
