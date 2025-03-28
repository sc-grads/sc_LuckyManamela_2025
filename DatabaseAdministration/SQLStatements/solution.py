import pandas as pd

# Create sample movie data (simulating the IMDb+Movie+Database.xlsx dataset)
data = {
    'Title': ['Movie A', 'Movie B', 'Movie C', 'Movie D', 'Movie E', 'Movie F', 'Movie G', 'Movie H', 'Movie I', 'Movie J'],
    'Genre': ['Action', 'Comedy', 'Action', 'Drama', 'Action', 'Comedy', 'Drama', 'Horror', 'Comedy', 'Horror'],
    'Year': [2010, 2011, 2010, 2012, 2013, 2011, 2012, 2014, 2013, 2014],
    'Director': ['Director 1', 'Director 2', 'Director 3', 'Director 1', 'Director 4', 'Director 2', 'Director 3', 'Director 5', 'Director 6', 'Director 5'],
    'IMDb_Rating': [7.2, 6.5, 7.8, 8.1, 6.9, 7.3, 8.5, 5.8, 7.0, 6.2],
    'Votes': [150000, 80000, 200000, 250000, 90000, 110000, 300000, 50000, 95000, 60000],
    'Budget': [50, 30, 70, 40, 60, 35, 45, 20, 25, 22],
    'BoxOffice': [200, 120, 300, 150, 220, 130, 180, 70, 100, 90],
    'Country': ['USA', 'USA', 'UK', 'USA', 'Canada', 'USA', 'UK', 'USA', 'USA', 'Canada']
}
df = pd.DataFrame(data)

# Pivot Table 1: Average IMDb Rating by Genre
pivot_avg_rating = pd.pivot_table(df, values='IMDb_Rating', index='Genre', aggfunc='mean').reset_index()

# Pivot Table 2: Movie Count by Year
pivot_movie_count = pd.pivot_table(df, values='Title', index='Year', aggfunc='count').reset_index().rename(columns={'Title':'Movie Count'})

# Pivot Table 3: Total Box Office Revenue by Country
pivot_boxoffice = pd.pivot_table(df, values='BoxOffice', index='Country', aggfunc='sum').reset_index()

# Pivot Table 4: Profit Analysis
df['Profit'] = df['BoxOffice'] - df['Budget']
pivot_profit = pd.pivot_table(df, values='Profit', index='Genre', aggfunc='sum').reset_index()

# Pivot Table 5: Percentage of Movies by Genre
genre_counts = df['Genre'].value_counts().reset_index()
genre_counts.columns = ['Genre', 'Movie Count']
genre_counts['Percentage'] = (genre_counts['Movie Count'] / genre_counts['Movie Count'].sum()) * 100

# Instructions sheet content
instructions = (
    "Pivot Table Instructions and Examples:\n\n"
    "1. Average IMDb Rating by Genre:\n"
    "   - Rows: Genre\n"
    "   - Values: Average of IMDb_Rating\n\n"
    "2. Movie Count by Release Year:\n"
    "   - Rows: Year\n"
    "   - Values: Count of Movies\n\n"
    "3. Total Box Office Revenue by Country:\n"
    "   - Rows: Country\n"
    "   - Values: Sum of BoxOffice\n\n"
    "4. Profit Analysis:\n"
    "   - Calculated Field: Profit = BoxOffice - Budget\n"
    "   - Rows: Genre\n"
    "   - Values: Sum of Profit\n\n"
    "5. Percentage of Movies by Genre:\n"
    "   - Derived by calculating the percentage of movie count for each genre.\n\n"
    "This workbook demonstrates how to simulate pivot tables, create calculated fields, and "
    "organize data for visualization in Excel, inspired by the examples provided in the PDF."
)

# Write the workbook to an Excel file with multiple sheets
with pd.ExcelWriter("Solution.xlsx", engine="xlsxwriter") as writer:
    df.to_excel(writer, sheet_name="Raw Data", index=False)
    pivot_avg_rating.to_excel(writer, sheet_name="Avg IMDb Rating", index=False)
    pivot_movie_count.to_excel(writer, sheet_name="Movie Count", index=False)
    pivot_boxoffice.to_excel(writer, sheet_name="Total BoxOffice", index=False)
    pivot_profit.to_excel(writer, sheet_name="Profit Analysis", index=False)
    genre_counts.to_excel(writer, sheet_name="Movies by Genre", index=False)
    
    # Add the Instructions sheet
    workbook  = writer.book
    worksheet = workbook.add_worksheet("Instructions")
    worksheet.write(0, 0, instructions)
    
print("Solution.xlsx has been generated.")
