import SwiftUI
import Combine

struct Restaurant: Identifiable, Hashable {
    let id: String
    let title: String
    let cuisine: CuisineOption
}

enum CuisineOption: String {
    case american, italian, chinese, japanese, maxican
}

actor SearchableDataManager {
    func fetchData() async throws -> [Restaurant]{
        do {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            return [
                Restaurant(id: UUID().uuidString, title: "Burger Shack", cuisine: .american),
                Restaurant(id: UUID().uuidString, title: "Pasta Palace", cuisine: .italian),
                Restaurant(id: UUID().uuidString, title: "Sushi Heaven", cuisine: .japanese),
                Restaurant(id: UUID().uuidString, title: "The Taco Bell", cuisine: .maxican),
                Restaurant(id: UUID().uuidString, title: "Local Market", cuisine: .chinese),
            ].shuffled()
        } catch {
            throw error
        }
    }
}

@MainActor
final class SearchableViewModel: ObservableObject{
    @Published private var restaurants: [Restaurant] = []
    @Published private(set) var filteredRestaurants: [Restaurant] = []
    @Published var searchText: String = ""
    @Published private(set) var searchScopes: [SearchCuisineOption] = []
    @Published var searchScope: SearchCuisineOption = .all
    
    private let manager = SearchableDataManager()
    private var cancelables = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
    }
    
    private func addSubscribers(){
        $searchText
            .combineLatest($searchScope)
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] (text, scope) in
                self?.filterRestaurants(searchBy: text, scope: scope)
            }
            .store(in: &cancelables)
    }
    
    func isSearching() -> Bool {
        !searchText.isEmpty
    }
    
    private func filterRestaurants(searchBy: String, scope: SearchCuisineOption) {
        guard !searchBy.isEmpty else {
            filteredRestaurants = restaurants
            searchScope = .all
            return
        }
        
        // Filter by Scope
        var restaurants:[Restaurant] = []
        switch scope {
        case .all:
            restaurants = self.restaurants
            break
        case .cuisine(option: let option):
            restaurants = self.restaurants.filter({$0.cuisine == option})
        }
        
        // Filter by Text
        let text = searchBy.lowercased()
        filteredRestaurants = restaurants.filter({
            let isTitleContains = $0.title.lowercased().contains(text)
            let isCuisineContains = $0.cuisine.rawValue.lowercased().contains(text)
            return isTitleContains || isCuisineContains
        })
    }
    
    func getSuggestions() -> [String] {
        var suggestions: [String] = []
        
        guard searchText.count < 3 else {
            return suggestions
        }
        
        suggestions.append(contentsOf: restaurants.map({$0.cuisine.rawValue.capitalized}))
        return suggestions
    }
    
    func getRestaurantSuggestions() -> [Restaurant] {
        var suggestions: [Restaurant] = []
        
        guard searchText.count < 3 else {
            return suggestions
        }
        
        suggestions.append(contentsOf: restaurants.filter({
            return $0.title.lowercased().contains(searchText.lowercased())
        }))
        
        return suggestions
    }
    
    func getRestaurants() async {
        do{
            restaurants = try await manager.fetchData()
            filteredRestaurants = restaurants
            
            let allCuisines = Set(restaurants.map({$0.cuisine}))
            
            searchScopes = [.all] + allCuisines.map({SearchCuisineOption.cuisine(option: $0)})
        }
        catch {
            print(error)
        }
    }
    
    enum SearchCuisineOption: Hashable {
        case all
        case cuisine(option: CuisineOption)
        
        var title: String {
            switch self {
            case .all:
                return "All"
            case .cuisine(option: let option):
                return option.rawValue.capitalized
            }
        }
    }
}

struct SearchableBootcamp: View {
    
    @StateObject var viewmodel = SearchableViewModel()
    
    var body: some View {
        ScrollView{
            VStack(spacing: 12) {
                SearchingView()
                ForEach(viewmodel.filteredRestaurants){ restaurant in
                    NavigationLink(value: restaurant) {
                        restaurantItem(restaurant: restaurant)
                    }
                }
            }
        }
        .padding(.all)
        .searchable(text: $viewmodel.searchText, placement: .automatic, prompt: "Search...")
        .searchScopes($viewmodel.searchScope){
            ForEach(viewmodel.searchScopes, id: \.self){
                Text($0.title)
                    .tag($0)
            }
        }
        .searchSuggestions{
            ForEach(viewmodel.getSuggestions(), id: \.self){
                Text($0)
                    .searchCompletion($0)
            }
            ForEach(viewmodel.getRestaurantSuggestions()){ restaurant in
                NavigationLink(value: restaurant) {
                    Text(restaurant.title)
                }
            }
        }
        .refreshable {
            await viewmodel.getRestaurants()
        }
        .task {
            await viewmodel.getRestaurants()
        }
        .navigationTitle("Restaurants")
        .navigationDestination(for: Restaurant.self) {
            Text($0.title)
        }
    }
    
    private func restaurantItem(restaurant: Restaurant) -> some View {
        VStack(alignment: .leading, spacing: 4){
            Text(restaurant.title)
                .font(.headline)
                .foregroundColor(.black)
            
            Text(restaurant.cuisine.rawValue.capitalized)
                .font(.caption)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black.opacity(0.05))
        .cornerRadius(8)
    }
}

struct SearchingView: View {
    
    @Environment(\.isSearching) private var isSearching
    
    var body: some View{
        if isSearching {
            Text("Seraching...")
                .font(.caption)
                .italic()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct SearchableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SearchableBootcamp()
        }
    }
}
