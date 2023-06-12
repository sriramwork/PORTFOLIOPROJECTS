--LOOKING AT THE DATA
SELECT * 
FROM [nashville housing]

--CONVERTING DATE INTO STANDARD FORMAT

ALTER TABLE [nashville housing]
ADD SALEDATECONVERTED DATE;

UPDATE [nashville housing]
SET SALEDATECONVERTED = CONVERT(DATE,SaleDate)

SELECT SALEDATECONVERTED
FROM [nashville housing]

--POPULATING PROPERTY ADDRESS DATA
SELECT *
FROM [nashville housing]
WHERE PropertyAddress IS NULL

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From [nashville housing] a
JOIN [nashville housing] b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From [nashville housing] a
JOIN [nashville housing] b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

--SPLITTING ADDRESS INTO SEPERATE COLUMNS (ADDRESS, CITY, STATE)
SELECT PROPERTYADDRESS
FROM [nashville housing]

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address
FROM [nashville housing]

ALTER TABLE [nashville housing]
Add PropertySplitAddress Nvarchar(255);

Update [nashville housing]
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE [nashville housing]
Add PropertySplitCity Nvarchar(255);

Update [nashville housing]
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

SELECT *
FROM [nashville housing]

SELECT
PARSENAME(REPLACE(OWNERADDRESS,',','.'), 3),
PARSENAME(REPLACE(OWNERADDRESS,',','.'), 2),
PARSENAME(REPLACE(OWNERADDRESS,',','.'), 1)
FROM [nashville housing]

ALTER TABLE [nashville housing]
Add OwnerSplitAddress Nvarchar(255);

Update [nashville housing]
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE [nashville housing]
Add OwnerSplitCity Nvarchar(255);

Update [nashville housing]
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE [nashville housing]
Add OwnerSplitState Nvarchar(255);

Update [nashville housing]
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)


SELECT DISTINCT(SOLDASVACANT),COUNT(SOLDASVACANT)
FROM [nashville housing]
GROUP BY SoldAsVacant
ORDER BY 2

Update [nashville housing]
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END

--REMOVE DUPLICATES

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num
From [nashville housing]
--order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress

SELECT *
FROM [nashville housing]

--DELETING UNWANTED COLUMNS 

ALTER TABLE [nashville housing]
DROP COLUMN OWNERADDRESS, PROPERTYADDRESS, SALEDATE

Select *
From [nashville housing]



