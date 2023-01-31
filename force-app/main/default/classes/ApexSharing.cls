public class ApexSharing {

    /**
     * Holds all pending shares for a particular record of type objName. Used to ensure
     * we only add a single share for the record being shared and user if different
     * access levels are being added. This is to prevent SF default behavior of keeping
     * the last element in the list thereby discarding any earlier list elements
     */
    public class ShareWrapper {
        protected String objName;
        protected Map<Id, List<SObject>> sharesByParentId = new Map<Id, List<SObject>>();
        protected String accessLevelFieldName = 'AccessLevel';
        protected String parentIdFieldName = 'ParentId';

        public ShareWrapper() {}
        
        public ShareWrapper(String objName) {
            this.objName = objName;
            if (!objName.endsWithIgnoreCase('__c')) {
                accessLevelFieldName = objName + 'AccessLevel';
                parentIdFieldName = objName + 'Id';
            }
        }
        public List<SObject> getShares(Id parentId) {
            return sharesByParentId.get(parentId);
        }

        /**
         * Return all shares for our given objName and all Records being shared.
         *
         * @return list of Share records to be inserted into database
         */
        public List<SObject> getAllShares() {
            List<SObject> sharesToAdd = new List<SObject>();
            for (Id recordToShareId : sharesByParentId.keyset()) {
                sharesToAdd.addAll(sharesByParentId.get(recordToShareId));
            }
            return sharesToAdd;
        }

        /**
         * Add shareToAdd to our list if we do not already have a Share for the same Access or higher. If we have a share
         * for lower/lesser access, replace it with the new share and do not add a redundant one
         *
         * @param shareToAdd share record to add for our object name and the record id within shareToAdd
         */
        public void add(SObject shareToAdd) {
            Id recordToShareId = (Id)shareToAdd.get(parentIdFieldName);

            if (sharesByParentId.get(recordToShareId) == null) {
                sharesByParentId.put(recordToShareId, new List<SObject>());
            }

            Boolean blnAddShare = true;
            for (SObject share : getShares(recordToShareId)) {
                if (share.get('UserOrGroupId') == shareToAdd.get('UserOrGroupId') &&
                        share.get('RowCause') == shareToAdd.get('RowCause')) {
                    blnAddShare = false; // avoid adding duplicates
                    // if share's current access is READ and we are adding EDIT, then replace share in map
                    if (share.get(accessLevelFieldName) == 'READ' && shareToAdd.get(accessLevelFieldName) == 'EDIT') {
                        // replace our share
                        share.put(accessLevelFieldName, 'EDIT');
                    }
                }
            }
            if (blnAddShare) {
                sharesByParentId.get(recordToShareId).add(shareToAdd);
            }
            System.debug('sharesByParentId ==> ' + sharesByParentId);
        }
    }
}