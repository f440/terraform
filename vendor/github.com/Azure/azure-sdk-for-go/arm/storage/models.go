package storage

// Copyright (c) Microsoft and contributors.  All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//
// See the License for the specific language governing permissions and
// limitations under the License.
//
// Code generated by Microsoft (R) AutoRest Code Generator 0.12.0.0
// Changes may cause incorrect behavior and will be lost if the code is
// regenerated.

import (
	"github.com/Azure/azure-sdk-for-go/Godeps/_workspace/src/github.com/Azure/go-autorest/autorest"
	"github.com/Azure/azure-sdk-for-go/Godeps/_workspace/src/github.com/Azure/go-autorest/autorest/date"
)

// AccountStatus enumerates the values for account status.
type AccountStatus string

const (
	// Available specifies the available state for account status.
	Available AccountStatus = "Available"
	// Unavailable specifies the unavailable state for account status.
	Unavailable AccountStatus = "Unavailable"
)

// AccountType enumerates the values for account type.
type AccountType string

const (
	// PremiumLRS specifies the premium lrs state for account type.
	PremiumLRS AccountType = "Premium_LRS"
	// StandardGRS specifies the standard grs state for account type.
	StandardGRS AccountType = "Standard_GRS"
	// StandardLRS specifies the standard lrs state for account type.
	StandardLRS AccountType = "Standard_LRS"
	// StandardRAGRS specifies the standard ragrs state for account type.
	StandardRAGRS AccountType = "Standard_RAGRS"
	// StandardZRS specifies the standard zrs state for account type.
	StandardZRS AccountType = "Standard_ZRS"
)

// ProvisioningState enumerates the values for provisioning state.
type ProvisioningState string

const (
	// Creating specifies the creating state for provisioning state.
	Creating ProvisioningState = "Creating"
	// ResolvingDNS specifies the resolving dns state for provisioning state.
	ResolvingDNS ProvisioningState = "ResolvingDNS"
	// Succeeded specifies the succeeded state for provisioning state.
	Succeeded ProvisioningState = "Succeeded"
)

// Reason enumerates the values for reason.
type Reason string

const (
	// AccountNameInvalid specifies the account name invalid state for reason.
	AccountNameInvalid Reason = "AccountNameInvalid"
	// AlreadyExists specifies the already exists state for reason.
	AlreadyExists Reason = "AlreadyExists"
)

// UsageUnit enumerates the values for usage unit.
type UsageUnit string

const (
	// Bytes specifies the bytes state for usage unit.
	Bytes UsageUnit = "Bytes"
	// BytesPerSecond specifies the bytes per second state for usage unit.
	BytesPerSecond UsageUnit = "BytesPerSecond"
	// Count specifies the count state for usage unit.
	Count UsageUnit = "Count"
	// CountsPerSecond specifies the counts per second state for usage unit.
	CountsPerSecond UsageUnit = "CountsPerSecond"
	// Percent specifies the percent state for usage unit.
	Percent UsageUnit = "Percent"
	// Seconds specifies the seconds state for usage unit.
	Seconds UsageUnit = "Seconds"
)

// Account is the storage account.
type Account struct {
	autorest.Response `json:"-"`
	ID                *string             `json:"id,omitempty"`
	Name              *string             `json:"name,omitempty"`
	Type              *string             `json:"type,omitempty"`
	Location          *string             `json:"location,omitempty"`
	Tags              *map[string]*string `json:"tags,omitempty"`
	Properties        *AccountProperties  `json:"properties,omitempty"`
}

// AccountCheckNameAvailabilityParameters is
type AccountCheckNameAvailabilityParameters struct {
	Name *string `json:"name,omitempty"`
	Type *string `json:"type,omitempty"`
}

// AccountCreateParameters is the parameters to provide for the account.
type AccountCreateParameters struct {
	Location   *string                            `json:"location,omitempty"`
	Tags       *map[string]*string                `json:"tags,omitempty"`
	Properties *AccountPropertiesCreateParameters `json:"properties,omitempty"`
}

// AccountKeys is the access keys for the storage account.
type AccountKeys struct {
	autorest.Response `json:"-"`
	Key1              *string `json:"key1,omitempty"`
	Key2              *string `json:"key2,omitempty"`
}

// AccountListResult is the list storage accounts operation response.
type AccountListResult struct {
	autorest.Response `json:"-"`
	Value             *[]Account `json:"value,omitempty"`
}

// AccountProperties is
type AccountProperties struct {
	ProvisioningState   ProvisioningState `json:"provisioningState,omitempty"`
	AccountType         AccountType       `json:"accountType,omitempty"`
	PrimaryEndpoints    *Endpoints        `json:"primaryEndpoints,omitempty"`
	PrimaryLocation     *string           `json:"primaryLocation,omitempty"`
	StatusOfPrimary     AccountStatus     `json:"statusOfPrimary,omitempty"`
	LastGeoFailoverTime *date.Time        `json:"lastGeoFailoverTime,omitempty"`
	SecondaryLocation   *string           `json:"secondaryLocation,omitempty"`
	StatusOfSecondary   AccountStatus     `json:"statusOfSecondary,omitempty"`
	CreationTime        *date.Time        `json:"creationTime,omitempty"`
	CustomDomain        *CustomDomain     `json:"customDomain,omitempty"`
	SecondaryEndpoints  *Endpoints        `json:"secondaryEndpoints,omitempty"`
}

// AccountPropertiesCreateParameters is
type AccountPropertiesCreateParameters struct {
	AccountType AccountType `json:"accountType,omitempty"`
}

// AccountPropertiesUpdateParameters is
type AccountPropertiesUpdateParameters struct {
	AccountType  AccountType   `json:"accountType,omitempty"`
	CustomDomain *CustomDomain `json:"customDomain,omitempty"`
}

// AccountRegenerateKeyParameters is
type AccountRegenerateKeyParameters struct {
	KeyName *string `json:"keyName,omitempty"`
}

// AccountUpdateParameters is the parameters to update on the account.
type AccountUpdateParameters struct {
	Tags       *map[string]*string                `json:"tags,omitempty"`
	Properties *AccountPropertiesUpdateParameters `json:"properties,omitempty"`
}

// CheckNameAvailabilityResult is the CheckNameAvailability operation response.
type CheckNameAvailabilityResult struct {
	autorest.Response `json:"-"`
	NameAvailable     *bool   `json:"nameAvailable,omitempty"`
	Reason            Reason  `json:"reason,omitempty"`
	Message           *string `json:"message,omitempty"`
}

// CustomDomain is the custom domain assigned to this storage account. This
// can be set via Update.
type CustomDomain struct {
	Name         *string `json:"name,omitempty"`
	UseSubDomain *bool   `json:"useSubDomain,omitempty"`
}

// Endpoints is the URIs that are used to perform a retrieval of a public
// blob, queue or table object.
type Endpoints struct {
	Blob  *string `json:"blob,omitempty"`
	Queue *string `json:"queue,omitempty"`
	Table *string `json:"table,omitempty"`
	File  *string `json:"file,omitempty"`
}

// Resource is
type Resource struct {
	ID       *string             `json:"id,omitempty"`
	Name     *string             `json:"name,omitempty"`
	Type     *string             `json:"type,omitempty"`
	Location *string             `json:"location,omitempty"`
	Tags     *map[string]*string `json:"tags,omitempty"`
}

// Usage is describes Storage Resource Usage.
type Usage struct {
	Unit         UsageUnit  `json:"unit,omitempty"`
	CurrentValue *int       `json:"currentValue,omitempty"`
	Limit        *int       `json:"limit,omitempty"`
	Name         *UsageName `json:"name,omitempty"`
}

// UsageListResult is the List Usages operation response.
type UsageListResult struct {
	autorest.Response `json:"-"`
	Value             *[]Usage `json:"value,omitempty"`
}

// UsageName is the Usage Names.
type UsageName struct {
	Value          *string `json:"value,omitempty"`
	LocalizedValue *string `json:"localizedValue,omitempty"`
}
