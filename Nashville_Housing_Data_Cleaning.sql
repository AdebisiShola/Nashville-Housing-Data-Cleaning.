use SHOLA
SELECT*
FROM dbo.[Nashville Housing];

---Standardize Date format
SELECT saledateconverted, CONVERT(Date,SaleDate)
FROM dbo.[Nashville Housing];

Update dbo.[Nashville Housing]
Set saledate = CONVERT(Date,SaleDate)

Alter table dbo.[Nashville Housing]
add saledateconverted Date

Update dbo.[Nashville Housing]
Set saledateconverted = CONVERT(Date,SaleDate)

---Populate Property address Data

SELECT*
FROM dbo.[Nashville Housing]
order by ParceliD

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress)
FROM dbo.[Nashville Housing] a
JOIN dbo.[Nashville Housing] b
  ON a.ParcelID = b.ParcelID
 AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress IS NULL

update a 
SET propertyAddress = isnull(a.PropertyAddress,b.PropertyAddress)
FROM dbo.[Nashville Housing] a
JOIN dbo.[Nashville Housing] b
  ON a.ParcelID = b.ParcelID
 AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress IS NULL

----Breaking out Address into individual column(Address, City, State)
select propertyAddress 
From dbo.[Nashville Housing]

SELECT PropertyAddress,
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) AS City
FROM dbo.[Nashville Housing]

Alter table dbo.[Nashville Housing]
add propertysplitaddress Nvarchar(255)

Update dbo.[Nashville Housing]
Set propertysplitaddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) 

Alter table dbo.[Nashville Housing]
add propertysplitcity Nvarchar(255)
 
 Update dbo.[Nashville Housing]
 Set propertysplitcity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))

SELECT*
FROM dbo.[Nashville Housing]

SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) AS OwnerSplitAddress,
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) AS OwnerSplitCity,
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) AS OwnerSplitState
FROM dbo.[Nashville Housing]

Alter table dbo.[Nashville Housing]
add OwnerSplitAddress Nvarchar(255)

Update dbo.[Nashville Housing]
Set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) 

Alter table dbo.[Nashville Housing]
add OwnerSplitCity Nvarchar(255)

Update dbo.[Nashville Housing]
Set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) 

Alter table dbo.[Nashville Housing]
add OwnerSplitState Nvarchar(255)

Update dbo.[Nashville Housing]
Set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) 

SELECT*
FROM dbo.[Nashville Housing]

----cHANGE Y and N to Yes and NO in "Sold as Vacant Field"
SELECT DISTINCT(SoldAsVacant), Count(SoldAsVacant)
FROM dbo.[Nashville Housing]
Group by SoldAsVacant
Order by 2

SELECT SoldAsVacant,
 case when SoldAsVacant = 1 THEN 'Yes'
	when SoldAsVacant = 0 THEN 'No'
	ELSE 'UNKNOWN' END AS SoldAsVacantcleaned 
	FROM dbo.[Nashville Housing]

ALTER TABLE dbo.[Nashville Housing]
ALTER COLUMN Soldasvacant VARCHAR(3)

UPDATE dbo.[Nashville Housing]
SET SoldAsVacant =
    CASE
        WHEN SoldAsVacant = 'Y' THEN 'Yes'
        WHEN SoldAsVacant = 'N' THEN 'No'
        ELSE SoldAsVacant
    END;
SELECT DISTINCT(SoldAsVacant), Count(SoldAsVacant)
FROM dbo.[Nashville Housing]
Group by SoldAsVacant
Order by 2

----Remove Duplicates 
WITH ROWNUMCTE AS (
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY ParcelID,
             PropertyAddress,
             SalePrice,
             SaleDate,
             LegalReference
ORDER BY UniqueID
) AS Row_num
FROM dbo.[Nashville Housing]
)
DELETE FROM ROWNUMCTE
WHERE Row_num > 1

WITH ROWNUMCTE AS (
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY ParcelID,
             PropertyAddress,
             SalePrice,
             SaleDate,
             LegalReference
ORDER BY UniqueID
) AS Row_num
FROM dbo.[Nashville Housing]
)
Select*
FROM ROWNUMCTE
WHERE Row_num > 1

---Delete Unused column
SELECT*
FROM dbo.[Nashville Housing]

ALTER TABLE dbo.[Nashville Housing]
DROP COLUMN owneraddress,TaxDistrict,PropertyAddress,saledate