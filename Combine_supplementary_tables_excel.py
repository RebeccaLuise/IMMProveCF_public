import pandas as pd

# List of files
files = [
    "/Users/rebecca/Documents/Forschung/IMMProveCF/Manuscript_16S/Revision/SuppMaterial/Supp_table1_delta_clinPara_LME.xlsx",
  "/Users/rebecca/Documents/Forschung/IMMProveCF/Manuscript_16S/Revision/SuppMaterial/Supp_table2_clinParameters_LME.xlsx",
  "/Users/rebecca/Documents/Forschung/IMMProveCF/Manuscript_16S/Revision/SuppMaterial/Supp_table3_PERMANOVA_timepoint_sampleType.xlsx",
  "/Users/rebecca/Documents/Forschung/IMMProveCF/Manuscript_16S/Revision/SuppMaterial/Supp_table4_alphaDiversity_lmm.xlsx",
  "/Users/rebecca/Documents/Forschung/IMMProveCF/Manuscript_16S/Revision/SuppMaterial/Supp_table5_MetadeconfoundR_taxa.xlsx",
  "/Users/rebecca/Documents/Forschung/IMMProveCF/Manuscript_16S/Revision/SuppMaterial/Supp_table6_testedVariables.xlsx",
  "/Users/rebecca/Documents/Forschung/IMMProveCF/Manuscript_16S/Revision/SuppMaterial/Supp_table7_diffTaxa.xlsx",
  "/Users/rebecca/Documents/Forschung/IMMProveCF/Manuscript_16S/Revision/SuppMaterial/Supp_table8_metadeconfoundR_alphaDiversity.xlsx",
  "/Users/rebecca/Documents/Forschung/IMMProveCF/Manuscript_16S/Revision/SuppMaterial/Supp_table9_alphaDiversity_Control.xlsx",
  "/Users/rebecca/Documents/Forschung/IMMProveCF/Manuscript_16S/Revision/SuppMaterial/Supp_table10_diffTaxa_Controls.xlsx",
  "/Users/rebecca/Documents/Forschung/IMMProveCF/Manuscript_16S/Revision/SuppMaterial/Supp_table11_Z-scores_LMEs.xlsx",
  "/Users/rebecca/Documents/Forschung/IMMProveCF/Manuscript_16S/Revision/SuppMaterial/Supp_table12_selectedLungMicrobiomeMembers.xlsx",
  "/Users/rebecca/Documents/Forschung/IMMProveCF/Manuscript_16S/Revision/SuppMaterial/Supp_table13_DrugsandSolvents.xlsx",
  "/Users/rebecca/Documents/Forschung/IMMProveCF/Manuscript_16S/Revision/SuppMaterial/Supp_table14_caluclated diversity_indices.xlsx"
]

# Output file
output_file = "/Users/rebecca/Documents/Forschung/IMMProveCF/Manuscript_16S/Revision/SuppMaterial/Combined_Supplementary_Tables.xlsx"

# Function to truncate sheet names
def truncate_sheet_name(name, max_length=31):
    return name[:max_length]

# Create a writer
with pd.ExcelWriter(output_file, engine='openpyxl') as writer:
    for file in files:
        # Extract sheet name and truncate it
        sheet_name = file.split('/')[-1].split('.')[0]
        truncated_name = truncate_sheet_name(sheet_name)
        # Read the Excel file
        df = pd.read_excel(file)
        # Write to the combined file
        df.to_excel(writer, sheet_name=truncated_name, index=False)

print(f"Combined file saved to {output_file}")
