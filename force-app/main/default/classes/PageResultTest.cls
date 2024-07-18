@isTest
private class PageResultTest {
    @isTest
    static void testPageResult() {

        PageResult pageResult = new PageResult();
        
        pageResult.pageSize = 10;
        pageResult.pageNumber = 1;
        pageResult.totalItemCount = 100;
        pageResult.records = new List<Object>{'Record1', 'Record2', 'Record3'};
        
        System.assertEquals(10, pageResult.pageSize);
        System.assertEquals(1, pageResult.pageNumber);
        System.assertEquals(100, pageResult.totalItemCount);
        System.assertEquals(3, pageResult.records.size());
        System.assertEquals('Record1', pageResult.records[0]);
        System.assertEquals('Record2', pageResult.records[1]);
        System.assertEquals('Record3', pageResult.records[2]);
    }
}