import Foundation

class DoCatchTryThrowBootcampDataManager {
    let isActive: Bool = true
    
    func getTitle() -> String? {
        if(isActive){
            return "Title"
        }
        else {
            return nil
        }
    }
    
    func getTitle1() -> (title: String?, error: Error?) {
        if(isActive){
            return ("Title #1", nil)
        }
        else {
            return(nil, URLError(.badURL))
        }
    }
    
    func getTitle2() -> Result<String, Error> {
        if(isActive){
            return .success("Title #2")
        }
        else {
            return .failure(URLError(.appTransportSecurityRequiresSecureConnection))
        }
    }
    
    func getTitle3() throws -> String {
        if(!isActive){
            return "Title #3"
        }
        else {
            throw URLError(.backgroundSessionInUseByAnotherProcess)
        }
    }
    
    func getTitle4() throws -> String {
        if(isActive){
            return "Title #4"
        }
        else {
            throw URLError(.badServerResponse)
        }
    }
}

class DoCatchTryThrowBootcampViewModel: ObservableObject {
    
    @Published var text: String = "Starting text..."
    let manager = DoCatchTryThrowBootcampDataManager()
    
    func fetchTitle(){
        /*
         let title = manager.getTitle()
         if let title = newTitle {
         self.text = newTitle
         }
         */
        
        /*
         let data = manager.getTitle1()
         if let title = data.title {
         self.text = title
         }
         else if let error = data.error {
         self.text = error.localizedDescription
         }
         */
        
        /*
         let result = manager.getTitle2()
         switch result{
         case .success(let title):
             self.text = title
         case .failure(let error)
             self.text = error.localizedDescription
         }
         */
        
        /*
         let iDontCareThrowsTitle = try? manager.getTitle3()
         if let iDontCareThrowsTitle = iDontCareThrowsTitle {
             self.text = iDontCareThrowsTitle
         }
         */
        
        do{
            let title1 = try? manager.getTitle3()
            if let title1 = title1 {
                self.text = title1
            }
            
            let title2 = try manager.getTitle3()
            self.text = title2
            
        } catch let error {
            self.text = error.localizedDescription
        }
    }
    
}
