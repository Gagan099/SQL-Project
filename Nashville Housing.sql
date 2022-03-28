create database Housing;
use Housing;
create table Hdetails(UniqueID int, ParcelID int,LandUse varchar(50),PropertyAddress varchar(250),
SaleDate date, SalePrice int,LegalReference int,SoldAsVacant varchar(10),OwnerName varchar(100),
OwnerAddress varchar(250),OwnerCity varchar(100),OwnerState varchar(100),
Acreage float,TaxDistrict varchar(100),LandValue int,BuildingValue int,
TotalValue int,YearBuilt year,Bedrooms int,FullBath int,HalfBath int
);

select * from Hdetails;
alter table Hdetails add  NewSaleDate date ;

select SaleDate,
str_to_date(SaleDate,"%Y-%m-%d")
from Hdetails;

alter table Hdetails drop SaleDate;
set SaleDate = NewSaleDate;
select * from Hdetails;

update Hdetails
set NewSaleDate =str_to_date(SaleDate,"%Y-%m-%d");


-- Populate property Address
select * from Hdetails
order by ParcelID;


select HD1.ParcelID,HD1.PropertyAddress,HD2.ParcelID,HD2.PropertyAddress
from Hdetails as HD1
join Hdetails as HD2
on HD1.ParcelID=HD2.ParcelID
and HD1.UniqueID <> HD2.UniqueID
where HD1.PropertyAddress is null;


select HD1.ParcelID,HD1.PropertyAddress,HD2.ParcelID,HD2.PropertyAddress, 
ifnull(HD1.PropertyAddress,HD2.PropertyAddress)
from Hdetails as HD1
join Hdetails as HD2
on HD1.ParcelID=HD2.ParcelID
and HD1.UniqueID <> HD2.UniqueID
where HD1.PropertyAddress is null;


update  Hdetails as HD1
join Hdetails as HD2
 on HD1.ParcelID=HD2.ParcelID
 and HD1.UniqueID <> HD2.UniqueID
set HD1.PropertyAddress =ifnull(HD1.PropertyAddress,HD2.PropertyAddress)
where HD1.PropertyAddress is null;

select * from Hdetails
where PropertyAddress is null;

-----------------------------------------------------------------------------------------------
-- Working points
set sql_safe_updates=0;

update Hdetails set LandValue= Null
where LandValue="null";

alter table Hdetails 
modify Acreage float;

----------------------------------------------------------------------------------------------------------
-- Breaking out address into Individual Columns(Address,city,State)
select * from Hdetails;

select 
substr(PropertyAddress,1,locate(",",PropertyAddress)-1) as address
from Hdetails;

select 
substr(PropertyAddress,1,locate(",",PropertyAddress)-1) as address,
substr(PropertyAddress,locate(",",PropertyAddress)+1) as address1
from Hdetails;

alter table Hdetails add PropertySplitAddress varchar(250);
alter table Hdetails add PropertySplitCity varchar(250);

update Hdetails
set PropertySplitAddress = substr(PropertyAddress,1,locate(",",PropertyAddress)-1);

update Hdetails
set PropertySplitCity = substr(PropertyAddress,locate(",",PropertyAddress)+1);

select * from  Hdetails;

SELECT OwnerAddress, replace(OwnerAddress, ",","") as ReplacedString,
Length(OwnerAddress) - Length(replace(OwnerAddress, ",","")) as NoOfSpaces
FROM Hdetails;

select * from Hdetails;


select OwnerAddress,substring(
substring(OwnerAddress, ",",1),",",-1) as addre,
if(length(OwnerAddress)-length(replace(OwnerAddress,",",","))>1,
substring(
substring(OwnerAddress,",",2),",",-1),Null) as addre2,
substring(
SUBSTRING(OwnerAddress,",",3),",",-1) as addre3
from Hdetails;

-- change Y to yes and N to No in "Sold as vacant" field

select distinct(SoldAsVacant), count(*) as total
 from Hdetails
 group by SoldAsVacant
 order by 2;
 
 select SoldAsVacant,
 case
 when SoldAsVacant ="N" then "No"
 when SoldAsVacant ="Y" then "Yes"
 else SoldAsVacant
 end as OP
 from Hdetails;
 
 update Hdetails
 set SoldAsVacant=case
 when SoldAsVacant ="N" then "No"
 when SoldAsVacant ="Y" then "Yes"
 else SoldAsVacant
 end;


-- Remove Duplicates
Select * from Hdetails;
--- We have founf the duplicate values here, the duplicate values are displyed as 2
select *,
row_number() over(partition by ParcelID,LandUse,PropertyAddress,SalePrice,
LegalReference,NewSaleDate order by UniqueID) Row_Num
from Hdetails
order by ParcelID
;

--- now we will sort only duplicate values using CTE

with RowNumberCTE as(
select *,
row_number() over(partition by ParcelID,LandUse,PropertyAddress,SalePrice,
LegalReference,NewSaleDate order by UniqueID) Row_Num
from Hdetails
-- order by ParcelID
)
select * from RowNumberCTE 
where  Row_Num >1
order by ParcelID
;

-- Now are going to remove the selected duplicate values
with RowNumberCTE as(
select *,
row_number() over(partition by ParcelID,LandUse,PropertyAddress,SalePrice,
LegalReference,NewSaleDate order by UniqueID) Row_Num
from Hdetails
-- order by ParcelID
)
delete
from RowNumberCTE 
where  Row_Num >1;

set SQL_Safe_Updates=0; 

-- Now are going to remove the selected duplicate valu

DELETE  hd1 from Hdetails as hd1
inner join Hdetails as hd2
where hd1.LandUse=hd2.LandUse
 and hd1.SalePrice=hd2.SalePrice and hd1.LegalReference=hd2.LegalReference;
 
 -- Delete the useless columns
 alter table Hdetails
 drop column PropertyAddress;
 
alter table Hdetails
 drop column TaxDistrict;
 